//
//  Nanosecond.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

import Text

public class Nanosecond: AffixedWord
{
    public init()
    {
        super.init(prefixes: [Nano()], roots: [SecondOfTime()], suffixes: [Object()])
    }
}
