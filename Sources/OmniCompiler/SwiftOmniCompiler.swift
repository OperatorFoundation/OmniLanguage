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
        return try blueprint.transpile(.swift, indentation: 4)
    }

    func compileToBlueprint(name: Text, chain: EffectChain) throws -> Blueprint
    {
        return Function(
            visibility: .private,
            name: "handle\(name)".text,
            throwing: true,
            async: true,
            statements: try self.chainToStatements(chain)
        )
    }

    func chainToStatements(_ chain: EffectChain) throws -> [Statement]
    {
        let statement = try self.instanceToStatement(chain.instance)

        var results: [Statement] = [statement]

        if let (sequencer, nextChain) = chain.next
        {
            let statements: [Statement] = try self.sequencedChainToStatements(sequencer, nextChain)
            results.append(contentsOf: statements)
        }

        return results
    }

    func instanceToStatement(_ instance: EffectInstance) throws -> Statement
    {
        switch instance.effect
        {
            case let listenEffect as GhostwriterListenEffect:
                return try self.listenToStatement(listenEffect, instance.binding, instance.refinement)

            case let speakEffect as GhostwriterSpeakEffect:
                return try self.speakToStatement(speakEffect, instance.binding, instance.refinement)

            default:
                throw SwiftOmniCompilerError.unsupportedEffect(instance.effect)
        }
    }

    func sequencedChainToStatements(_ sequencer: Sequencer, _ nextChain: EffectChain) throws -> [Statement]
    {
        // FIXME
        switch sequencer
        {
            // Blocking is the default behavior for a sequence of Swift statements.
            case is Blocking:
                return try self.chainToStatements(nextChain)

            // FIXME - for now, treat blocking and sequential as the same
            case is Sequential:
                return try self.chainToStatements(nextChain)

            default:
                throw SwiftOmniCompilerError.unsupportedSequencer(sequencer)
        }
    }

    func listenToStatement(_ effect: GhostwriterListenEffect, _ binding: Binding?, _ refinement: Refinement?) throws -> Statement
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
        if let refinement
        {
            guard refinement.name == "timeout" else
            {
                throw SwiftOmniCompilerError.unknownRefinementType(refinement.name)
            }

            switch refinement.value
            {
                case .timeDuration(let duration):
                    let seconds = duration.seconds()
                    let secondsInt = try seconds.toInt()
                    arguments.append(Argument(label: "timeout", value: .literal(.number(secondsInt))))

                default:
                    throw SwiftOmniCompilerError.unsupportedRefinementValueType(refinement.value)
            }
        }

        return Statement.expression(.functionCall(FunctionCall(
            trying: true,
            async: true,
            name: "self.listen",
            arguments: arguments
        )))
    }

    func speakToStatement(_ effect: GhostwriterSpeakEffect, _ binding: Binding?, _ refinement: Refinement?) throws -> Statement
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

        if let refinement
        {
            // speak doesn't support any refinements
            throw SwiftOmniCompilerError.unsupportedRefinement(refinement)
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

        return Argument(value: .literal(.constructor(.named("StructuredText"), literals)))
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
