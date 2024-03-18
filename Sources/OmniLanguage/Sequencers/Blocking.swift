//
//  Blocking.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Blocking: Sequencer
{
    public init(){}
}

extension Blocking: CustomStringConvertible
{
    public var description: String
    {
        return Awaiting().description
    }
}

extension Blocking
{
    public var glyphs: Text
    {
        return "÷"
    }
}
