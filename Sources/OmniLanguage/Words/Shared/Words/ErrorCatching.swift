//
//  ErrorCatching.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class ErrorCatching: AffixedWord
{
    public init()
    {
        super.init(roots: [Erroneous(), Catch()], suffixes: [Adverb()], glyphs: Catch().glyphs)
    }
}
