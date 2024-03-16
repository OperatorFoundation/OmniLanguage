//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text

public class Limitation: AffixedWord
{
    public init()
    {
        super.init(roots: [Limited()], suffixes: [Object()])
    }
}
