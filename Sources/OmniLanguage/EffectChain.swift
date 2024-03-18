//
//  EffectChain.swift
//
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Text

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

        if let (sequencer, chain) = self.next
        {
            result.append(", ")
            result.append(sequencer.description)
            result.append("\n")

            result.append(chain.description)
        }

        return result
    }
}

extension EffectChain
{
    public func findSpacing() -> Int
    {
        var spacing: Int = 1
        var current: EffectChain? = self
        while current != nil
        {
            spacing = max(spacing, current!.instance.glyphs.count())
            if let next = current!.next
            {
                let (_, nextInstance) = next
                current = nextInstance
            }
            else
            {
                current = nil
            }
        }

        return spacing
    }

    public func format(spacing: Int) -> Text
    {
        let result: MutableText = ""

        result.becomeAppended(instance.glyphs)

        let currentSpacing = spacing - instance.glyphs.count() + 1
        let spacingText = String(repeating: " ", count: currentSpacing).text

        if let (sequencer, chain) = self.next
        {
            result.becomeAppended(spacingText)
            result.becomeAppended(sequencer.glyphs)
            result.becomeAppended("\n")

            result.becomeAppended(chain.format(spacing: spacing))
        }

        return result.text
    }
}
