//
//  EffectChain.swift
//
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

public class EffectChain
{
    public let instance: EffectInstance
    public let next: (Sequencer, EffectChain)?

    public convenience init(instance: EffectInstance, sequencer: Sequencer, chain: EffectChain)
    {
        self.init(instance: instance, next: (sequencer, chain))
    }

    public init(instance: EffectInstance, next: (Sequencer, EffectChain)? = nil)
    {
        self.instance = instance
        self.next = next
    }
}

extension EffectChain: CustomStringConvertible
{
    public var description: String
    {
        var result: String = ""

        result.append(instance.description)
        result.append("\n")

        if let (sequencer, chain) = self.next
        {
            result.append(sequencer.description)
            result.append("\n")

            result.append(chain.description)
        }

        return result
    }
}
