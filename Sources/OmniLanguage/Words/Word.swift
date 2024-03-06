//
//  Word.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Word
{
    public var text: Text
    {
        return "unimplemented"
    }
}

extension Word: CustomStringConvertible
{
    public var description: String
    {
        return self.text.string
    }
}
