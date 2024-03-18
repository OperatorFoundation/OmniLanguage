//
//  Binding.swift
//
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Text

public struct Binding: Composition
{
    public let value: Value

    public init(value: Value)
    {
        self.value = value
    }
}

extension Binding: CustomStringConvertible
{
    public var description: String
    {
        return With().description + " " + value.description
    }
}

extension Binding
{
    public var glyphs: Text
    {
        return value.glyphs
    }
}
