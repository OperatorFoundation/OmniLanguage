//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

import Text

public class Millisecond: AffixedWord
{
    public init()
    {
        super.init(prefixes: [Milli()], roots: [SecondOfTime()], suffixes: [Object()])
    }
}
