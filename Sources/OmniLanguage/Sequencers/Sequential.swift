//
//  Sequential.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Sequential: Sequencer
{
    public init(){}
}

extension Sequential: CustomStringConvertible
{
    public var description: String
    {
        return Afterwards().description
    }
}

extension Sequential
{
    public var glyphs: Text
    {
        return ":"
    }
}
