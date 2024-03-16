//
//  SpeakCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class SpeakCommand: AffixedWord
{
    public init()
    {
        super.init(roots: [Speak()], suffixes: [Imperative()], glyphs: Speak().glyphs)
    }
}
