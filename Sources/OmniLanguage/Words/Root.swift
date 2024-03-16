//
//  Root.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Root
{
    public let spelling: Text
    public let glyphs: Text

    public init(spelling: Text, glyphs: Text)
    {
        self.spelling = spelling
        self.glyphs = glyphs
    }
}

extension Root
{
    var text: Text
    {
        return self.spelling
    }
}
