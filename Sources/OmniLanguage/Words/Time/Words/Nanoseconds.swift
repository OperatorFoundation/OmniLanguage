//
//  Nanoseconds.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text

public class Nanoseconds: AffixedWord
{
    public init()
    {
        let glyphs: MutableText = ""
        glyphs.becomeAppended(Second().glyphs)
        glyphs.becomeAppended(Nano().glyphs)
        glyphs.becomeAppended(Plural().glyphs)

        super.init(prefixes: [Nano()], roots: [SecondOfTime()], suffixes: [Object(), Plural()], glyphs: glyphs.text)
    }
}
