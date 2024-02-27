//
//  ErrorCatching.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class ErrorCatching: AffixedWord
{
    public init()
    {
        super.init(roots: [Error(), Catch()], suffixes: [Adverb()])
    }
}
