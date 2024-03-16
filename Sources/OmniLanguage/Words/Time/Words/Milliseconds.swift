//
//  Milliseconds.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text

public class Milliseconds: AffixedWord
{
    public init()
    {
        let glyphs: MutableText = ""
        glyphs.becomeAppended(Second().glyphs)
        glyphs.becomeAppended(Milli().glyphs)
        glyphs.becomeAppended(Plural().glyphs)

        super.init(prefixes: [Milli()], roots: [SecondOfTime()], suffixes: [Object(), Plural()], glyphs: glyphs.text)
    }
}
