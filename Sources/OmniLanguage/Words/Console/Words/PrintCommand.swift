//
//  PrintCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class PrintCommand: AffixedWord
{
    public init()
    {
        super.init(roots: [Print()], suffixes: [Imperative()])
    }
}
