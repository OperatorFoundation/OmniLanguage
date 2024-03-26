//
//  Effect.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public enum EffectGroup: Codable
{
    case console
    case logger
    case ghostwriter
    case flow
    case time
}

extension EffectGroup
{
    public var word: Word
    {
        switch self
        {
            case .console:
                return ConsoleObject()

            case .logger:
                return Logger()

            case .ghostwriter:
                return Author()

            case .flow:
                return Flow()

            case .time:
                return Time()
        }
    }
}

extension EffectGroup: CustomStringConvertible
{
    public var description: String
    {
        return self.word.description
    }
}

extension EffectGroup
{
    public var glyphs: Text
    {
        switch self
        {
            case .console:
                return self.word.glyphs

            case .logger:
                return self.word.glyphs

            case .ghostwriter:
                return Textual().glyphs

            case .flow:
                return Flowing().glyphs

            case .time:
                return Time().glyphs
        }
    }
}
