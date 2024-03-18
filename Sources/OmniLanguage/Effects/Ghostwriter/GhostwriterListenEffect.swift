//
//  GhostwriterListenEffect.swift
//
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Ghostwriter
import Number
import Text
import Time

public class GhostwriterListenEffect: Effect
{
    public typealias Bind = StructuredText
    public typealias Refine = GhostwriterListenRefinement

    public var group: EffectGroup = .ghostwriter

    public init()
    {
    }
}

public struct GhostwriterListenRefinement
{
    public let maxSize: Number
    public let timeout: TimeDuration
}

extension GhostwriterListenEffect: CustomStringConvertible
{
    public var description: String
    {
        return "\(self.group.description) \(ListenCommand().description)"
    }
}

extension GhostwriterListenEffect
{
    public var glyphs: Text
    {
        return "\(self.group.glyphs)\(ListenCommand().glyphs)".text
    }
}

