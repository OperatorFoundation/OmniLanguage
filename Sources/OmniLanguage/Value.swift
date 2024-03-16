//
//  Value.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

import Ghostwriter
import Number
import Text
import Time

public enum Value
{
    case number(Number)
    case text(Text)
    case structuredText(StructuredText)
    case time(Time)
    case timeDuration(TimeDuration)
}

extension Value: CustomStringConvertible
{
    public var description: String
    {
        switch self
        {
            case .number(let value):
                return value.description

            case .text(let value):
                return value.description

            case .structuredText(let value):
                return value.description

            case .time(let value):
                return value.description

            case .timeDuration(let value):
                return value.description
        }
    }
}

extension Value
{
    public var glyphs: Text
    {
        switch self
        {
            case .number(let value):
                return value.toText()

            case .text(let value):
                return value

            case .structuredText(let value):
                return value.description.text

            case .time(let value):
                return value.text

            case .timeDuration(let value):
                return value.glyphs
        }
    }
}
