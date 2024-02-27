//
//  Afterwards.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Afterwards: AffixedWord
{
    public init()
    {
        super.init(roots: [After()], suffixes: [Adverb()])
    }
}
