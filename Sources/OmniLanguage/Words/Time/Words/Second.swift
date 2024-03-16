//
//  Second.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text

public class Second: AffixedWord
{
    public init()
    {
        super.init(roots: [SecondOfTime()], suffixes: [Object()])
    }
}
