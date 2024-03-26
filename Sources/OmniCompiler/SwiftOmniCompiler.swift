//
//  SwiftOmniCompiler.swift
//
//
//  Created by Dr. Brandon Wiley on 3/5/24.
//

import Foundation

import Blueprint
import Ghostwriter
import OmniLanguage
import Text
import Time

public class SwiftOmniCompiler: OmniCompiler
{
    public init(){}
    
    public func compile(_ name: Text, _ chain: EffectChain) throws -> Text
    {
        let blueprint = try self.compileToBlueprint(name: name, chain: chain)
        return try blueprint.transpile(.swift, indentation: 1)
    }

    func compileToBlueprint(name: Text, chain: EffectChain) throws -> Blueprint
    {
        return Function(
            visibility: .private,
            name: "handle\(name)".text,
            throwing: true,
            async: true,
            statements: try self.firstChainToStatements(chain)
        )
    }

    func firstChainToStatements(_ chain: EffectChain) throws -> [Statement]
    {
        let statement = try self.instanceToStatement(chain.instance)

        var results: [Statement] = [statement]

        if let (sequencer, nextChain) = chain.next
        {
            results = try self.sequencedChainToStatements(statement, sequencer, nextChain)
        }

        return results
    }

    func chainToStatements(_ statement: Statement, _ chain: EffectChain) throws -> [Statement]
    {
        let statement = try self.instanceToStatement(chain.instance)

        var results: [Statement] = [statement]

        if let (sequencer, nextChain) = chain.next
        {
            results = try self.sequencedChainToStatements(statement, sequencer, nextChain)
        }

        return results
    }

    func instanceToStatement(_ instance: EffectInstance) throws -> Statement
    {
        switch instance.effect
        {
            case let listenEffect as GhostwriterListenEffect:
                return try self.listenToStatement(listenEffect, instance.binding, instance.refinements)

            case let speakEffect as GhostwriterSpeakEffect:
                return try self.speakToStatement(speakEffect, instance.binding, instance.refinements)

            case is EndProgramEffect:
                return .return

            default:
                throw SwiftOmniCompilerError.unsupportedEffect(instance.effect)
        }
    }

    func sequencedChainToStatements(_ statement: Statement, _ sequencer: Sequencer, _ nextChain: EffectChain) throws -> [Statement]
    {
        // FIXME
        switch sequencer
        {
            // Blocking is the default behavior for a sequence of Swift statements.
            case is Blocking:
                var results = [statement]
                let rest: [Statement] = try self.chainToStatements(statement, nextChain)
                results.append(contentsOf: rest)
                return results

            // Temporarily treat sequential the same as blocking
            case is Sequential:
                var results = [statement]
                let rest: [Statement] = try self.chainToStatements(statement, nextChain)
                results.append(contentsOf: rest)
                return results

            case let waiting as Waiting:
                return try self.chainToWaitingStatements(statement, waiting, nextChain)

            default:
                throw SwiftOmniCompilerError.unsupportedSequencer(sequencer)
        }
    }

    func chainToWaitingStatements(_ statement: Statement, _ waiting: Waiting, _ chain: EffectChain) throws -> [Statement]
    {
        var results: [Statement] = [try self.wrapWaiting(waiting, statement)]

        let instanceStatement = try self.instanceToStatement(chain.instance)

        if let (sequencer, nextChain) = chain.next
        {
            let statements: [Statement] = try self.sequencedChainToStatements(instanceStatement, sequencer, nextChain)
            results.append(contentsOf: statements)
        }
        else
        {
            results.append(instanceStatement)
        }

        return results
    }

    func wrapWaiting(_ waiting: Waiting, _ statement: Statement) throws -> Statement
    {
        let seconds = waiting.timeout.seconds()
        let secondsInt = try seconds.toInt()
        let argument = Argument(
            value: .literal(.enumCaseConstructor(EnumCaseConstructor(
                type: "Duration",
                name: "seconds",
                values: [
                    .literal(.number(secondsInt))
                ]
            )))
        )

        return .expression(.chain(ChainedExpression(
            lvalue: .constructorCall(ConstructorCall(
                name: "Timeout",
                arguments: [argument]
            )),
            rvalue: FunctionCall(
                trying: true,
                async: true,
                name: "wait",
                arguments: [
                    Argument(value: .literal(.closure(Closure(statements: [
                        statement
                    ]))))
                ]
            ))
        ))
    }

    func listenToStatement(_ effect: GhostwriterListenEffect, _ binding: Binding?, _ refinements: [Refinement]) throws -> Statement
    {
        guard let binding else
        {
            throw SwiftOmniCompilerError.bindingRequired
        }

        let structuredText: StructuredText
        switch binding.value
        {
            case .structuredText(let value):
                structuredText = value

            default:
                throw SwiftOmniCompilerError.bindingTypeMismtatch
        }

        var arguments: [Argument] = try [self.structuredTextToArgument(structuredText)]
        for refinement in refinements
        {
            switch refinement 
            {                    
                case is MaxSize:
                    switch refinement.value
                    {
                        case .number(let maxSize):
                            arguments.append(Argument(label: "maxSize", value: .literal(.number(try maxSize.toInt()))))
                        
                        default:
                            throw SwiftOmniCompilerError.unsupportedRefinementValueType(refinement.value)
                    }
                
                default:
                    throw SwiftOmniCompilerError.unsupportedRefinement(refinement)
            }
        }

        return Statement.assignment(
            .variableDefinition(VariableDefinition(name: "_")),
            .functionCall(FunctionCall(
                trying: true,
                async: true,
                name: "self.listen",
                arguments: arguments
            ))
        )
    }

    func speakToStatement(_ effect: GhostwriterSpeakEffect, _ binding: Binding?, _ refinements: [Refinement]) throws -> Statement
    {
        guard let binding else
        {
            throw SwiftOmniCompilerError.bindingRequired
        }

        let structuredText: StructuredText
        switch binding.value
        {
            case .structuredText(let value):
                structuredText = value

            default:
                throw SwiftOmniCompilerError.bindingTypeMismtatch
        }

        guard refinements.isEmpty else
        {
            // speak doesn't support any refinements
            throw SwiftOmniCompilerError.unsupportedRefinement(refinements[0])
        }

        return Statement.expression(.functionCall(FunctionCall(
            trying: true,
            async: true,
            name: "self.speak",
            arguments: [try self.structuredTextToArgument(structuredText)]
        )))
    }

    func structuredTextToArgument(_ structuredText: StructuredText) throws -> Argument
    {
        let literals: [LiteralValue] = try structuredText.texts.map(self.typedTextToLiteralValue)

        return Argument(label: "structuredText", value: .literal(.constructor(.named("StructuredText"), literals)))
    }

    func typedTextToLiteralValue(_ typedText: TypedText) throws -> LiteralValue
    {
        switch typedText
        {
            case .generator(_):
                throw SwiftOmniCompilerError.unsupportedTypedText(typedText)

            case .newline(let value):
                return .enumCaseConstructor(EnumCaseConstructor(
                    type: "TypedText",
                    name: "newline",
                    values: [
                        .literal(.enumCaseConstructor(EnumCaseConstructor(
                            type: "Newline",
                            name: value.rawValue.text
                        )))
                    ]
                ))

            case .regexp(let value):
                return .enumCaseConstructor(EnumCaseConstructor(
                    type: "TypedText",
                    name: "regexp",
                    values: [.literal(.string(value.text))]
                ))

            case .special(let value):
                return .enumCaseConstructor(EnumCaseConstructor(
                    type: "TypedText",
                    name: "special",
                    values: [
                        .literal(.enumCaseConstructor(EnumCaseConstructor(
                            type: "SpecialCharacter",
                            name: value.rawValue.text
                        )))                    
                    ]
                ))

            case .string(let value):
                return .enumCaseConstructor(EnumCaseConstructor(
                    type: "TypedText",
                    name: "string",
                    values: [.literal(.string(value.text))]
                ))

            case .text(let value):
                return .enumCaseConstructor(EnumCaseConstructor(
                    type: "TypedText",
                    name: "text",
                    values: [.literal(.string(value))]
                ))

        }
    }
}

public enum SwiftOmniCompilerError: Error
{
    case unsupportedEffect(Effect)
    case bindingRequired
    case bindingTypeMismtatch
    case unknownRefinementType(Text)
    case unsupportedRefinementValueType(Value)
    case unsupportedRefinement(Refinement)
    case unsupportedSequencer(Sequencer)
    case unsupportedTypedText(TypedText)
}
