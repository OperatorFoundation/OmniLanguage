//
//  CompoundWord.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class CompoundWord: Word
{
    public override var text: Text
    {
        let result: MutableText = ""

        for part in self.parts
        {
            result.becomeAppended(part.text)
        }

        return result.text
    }

    let parts: [Word]

    public init(parts: [AffixedWord])
    {
        self.parts = parts
    }
}
