//
//  GhostwriterSpeakEffect.swift
//
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Ghostwriter
import Text

public class GhostwriterSpeakEffect: Effect
{
    public typealias Bind = StructuredText
    public typealias Refine = ()

    public var group: EffectGroup = .ghostwriter

    public init()
    {
    }
}

extension GhostwriterSpeakEffect: CustomStringConvertible
{
    public var description: String
    {
        return "\(self.group.description).\(SpeakCommand().description)"
    }
}

extension GhostwriterSpeakEffect
{
    public var glyphs: Text
    {
        return "\(self.group.glyphs).\(SpeakCommand().glyphs)".text
    }
}
