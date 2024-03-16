//
//  Indifferent.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Indifferent: Sequencer
{
    public init(){}
}

extension Indifferent: CustomStringConvertible
{
    public var description: String
    {
        return Also().description
    }
}

extension Indifferent
{
    public var glyphs: Text
    {
        return Also().glyphs
    }
}
