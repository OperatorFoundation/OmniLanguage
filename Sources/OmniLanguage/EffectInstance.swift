//
//  Orchestration.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

public struct EffectInstance
{
    public var effect: Effect
    public var binding: Binding?
    public var refinement: Refinement?

    public init(effect: Effect, binding: Binding? = nil, refinement: Refinement? = nil)
    {
        self.effect = effect
        self.binding = binding
        self.refinement = refinement
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

        if let refinement = self.refinement
        {
            result.append(" "+refinement.description)
        }

        return result
    }
}
