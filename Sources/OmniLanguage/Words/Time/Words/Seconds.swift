//
//  Seconds.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text

public class Seconds: AffixedWord
{
    public init()
    {
        let glyphs: MutableText = ""
        glyphs.becomeAppended(SecondOfTime().glyphs)
        glyphs.becomeAppended(Plural().glyphs)

        super.init(roots: [SecondOfTime()], suffixes: [Object(), Plural()], glyphs: glyphs.text)
    }
}
