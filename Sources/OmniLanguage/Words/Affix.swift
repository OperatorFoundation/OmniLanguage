//
//  Affix.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Affix
{
    public let spelling: Text

    public init(spelling: Text)
    {
        self.spelling = spelling
    }
}

public class Prefix: Affix
{
}

public class Suffix: Affix
{
}

extension Affix
{
    public var text: Text
    {
        return self.spelling
    }
}
