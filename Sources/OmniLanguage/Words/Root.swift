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

    public init(spelling: Text)
    {
        self.spelling = spelling
    }
}

extension Root
{
    var text: Text
    {
        return self.spelling
    }
}
