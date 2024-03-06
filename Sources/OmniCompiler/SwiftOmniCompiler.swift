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

        var arguments: [Argument] = [self.structuredTextToArgument(structuredText)]
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
            name: "self.speak",
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
            name: "self.speak",
            arguments: [self.structuredTextToArgument(structuredText)]
        )))
    }

    func structuredTextToArgument(_ structuredText: StructuredText) -> Argument
    {
        let literals: [LiteralValue] = structuredText.texts.map(self.typedTextToLiteralValue)

        return Argument(value: .literal(.constructor(.named("StructuredText"), literals)))
    }

    func typedTextToLiteralValue(_ typedText: TypedText) -> LiteralValue
    {
        switch typedText
        {
            case .generator(let value):
                throw SwiftOmniCompilerError.unsupportedEffect(typedText)

            case .newline(let value):
                return LiteralValue.constructor(
                    .named("TypedText.newline"),
                    [
                        .constructor(.named(<#T##Text#>), <#T##[LiteralValue]#>)
                    ]
                )

            case .regexp(let value):


            case .special(let value):
            case .string(let value):
            case .text(let value):
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
