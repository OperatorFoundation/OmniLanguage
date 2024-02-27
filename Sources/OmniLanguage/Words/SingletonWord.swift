//
//  SingletonWord.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class SingletonWord: Word
{
    public override var text: Text
    {
        return self.spelling
    }

    public let spelling: Text

    public init(spelling: Text)
    {
        self.spelling = spelling
    }
}
