//
//  Word.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class AffixedWord: Word
{
    public let prefixes: [Prefix]
    public let roots: [Root]
    public let suffixes: [Suffix]

    public init(prefixes: [Prefix] = [], roots: [Root] = [], suffixes: [Suffix] = [], glyphs: Text? = nil)
    {
        self.prefixes = prefixes
        self.roots = roots
        self.suffixes = suffixes

        if let glyphs
        {
            super.init(glyphs: glyphs)
        }
        else
        {
            let result: MutableText = ""
            
            for affix in self.prefixes
            {
                result.becomeAppended(affix.glyphs)
            }
            
            for root in self.roots
            {
                result.becomeAppended(root.glyphs)
            }
            
            for affix in self.suffixes
            {
                result.becomeAppended(affix.glyphs)
            }
            
            super.init(glyphs: result.text)
        }
    }

    public override var text: Text
    {
        let result: MutableText = ""

        for affix in self.prefixes
        {
            result.becomeAppended(affix.text)
        }

        for root in self.roots
        {
            result.becomeAppended(root.text)
        }

        for affix in self.suffixes
        {
            result.becomeAppended(affix.text)
        }

        return result.text
    }
}
