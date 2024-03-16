//
//  Refinement.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

import Text

public class Refinement: Composition
{
    public let name: Text
    public let nameGlyphs: Text
    public let value: Value
    
    public init(name: Text, glyphs: Text, value: Value) {
        self.name = name
        self.nameGlyphs = glyphs
        self.value = value
    }
}

extension Refinement: CustomStringConvertible
{
    public var description: String
    {
        return "\(LikeThis().description) \"\(name) \(Is().description) \(value.description).\""
    }
}

extension Refinement
{
    public var glyphs: Text
    {
        return "⚙ \(self.nameGlyphs): \(value.glyphs)".text
    }
}
