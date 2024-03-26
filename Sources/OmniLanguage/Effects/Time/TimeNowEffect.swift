//
//  TimeNowEffect.swift
//
//
//  Created by Dr. Brandon Wiley on 3/25/24.
//

import Foundation

import Ghostwriter
import Text
import Time

public class TimeNowEffect: Effect
{
    public typealias Bind = Block<Time>
    public typealias Refine = ()

    public var group: EffectGroup = .time

    public init()
    {
    }
}

extension TimeNowEffect: CustomStringConvertible
{
    public var description: String
    {
        return "\(self.group.description) \(SpeakCommand().description)"
    }
}

extension TimeNowEffect
{
    public var glyphs: Text
    {
        return "\(self.group.glyphs)\(SpeakCommand().glyphs)".text
    }
}
