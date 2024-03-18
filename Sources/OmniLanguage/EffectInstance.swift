//
//  Orchestration.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

import Text

public struct EffectInstance
{
    public var effect: Effect
    public var binding: Binding?
    public var refinements: [Refinement]

    public init(effect: Effect, binding: Binding? = nil, refinements: [Refinement] = [])
    {
        self.effect = effect
        self.binding = binding
        self.refinements = refinements
    }
}

extension EffectInstance: CustomStringConvertible
{
    public var description: String
    {
        var result = ""

        result.append(effect.description)

        if let binding = self.binding
        {
            result.append(" "+binding.description)
        }

        for refinement in self.refinements
        {
            result.append(" "+refinement.description)
        }

        return result
    }
}

extension EffectInstance
{
    public var glyphs: Text
    {
        let result: MutableText = ""

        result.becomeAppended(effect.glyphs)

        if let binding = self.binding
        {
            result.becomeAppended(" ")
            result.becomeAppended(binding.glyphs)
        }

        for refinement in self.refinements
        {
            result.becomeAppended(" ")
            result.becomeAppended(refinement.glyphs)
        }

        return result.text
    }
}
