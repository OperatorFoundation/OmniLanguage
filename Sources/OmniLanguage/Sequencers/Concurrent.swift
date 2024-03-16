//
//  Concurrent.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Concurrent: Sequencer
{
    public init(){}
}

extension Concurrent: CustomStringConvertible
{
    public var description: String
    {
        return Simultaneously().description
    }
}

extension Concurrent
{
    public var glyphs: Text
    {
        return Simultaneously().glyphs
    }
}
