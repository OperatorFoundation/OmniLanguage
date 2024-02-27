//
//  LogCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class LogCommand: AffixedWord
{
    public init()
    {
        super.init(roots: [Write()], suffixes: [Imperative()])
    }
}