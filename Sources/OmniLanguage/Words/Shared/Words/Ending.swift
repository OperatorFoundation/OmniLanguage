//
//  Ending.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

import Text

public class Ending: AffixedWord
{
    public init()
    {
        super.init(roots: [End()], suffixes: [Object()])
    }
}
