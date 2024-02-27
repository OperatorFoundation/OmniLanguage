//
//  Awaiting.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Awaiting: AffixedWord
{
    public init()
    {
        super.init(roots: [Wait()], suffixes: [Adverb()])
    }
}
