//
//  Catching.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Catching: Sequencer
{
    public init(){}
}

extension Catching: CustomStringConvertible
{
    public var description: String
    {
        return ErrorCatching().description
    }
}

extension Catching
{
    public var glyphs: Text
    {
        return ErrorCatching().glyphs
    }
}
