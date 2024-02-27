//
//  ListenCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class ListenCommand: AffixedWord
{
    public init()
    {
        super.init(roots: [Listen()], suffixes: [Imperative()])
    }
}
