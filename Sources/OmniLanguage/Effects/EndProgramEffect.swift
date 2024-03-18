//
//  EndProgramEffect.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

import Text

public class EndProgramEffect: Effect
{
    public var group: EffectGroup = .flow

    public init()
    {
    }
}

extension EndProgramEffect: CustomStringConvertible
{
    public var description: String
    {
        return "\(self.group.description) \(Ending().description)"
    }
}

extension EndProgramEffect
{
    public var glyphs: Text
    {
        return " \(End().glyphs)".text
    }
}
