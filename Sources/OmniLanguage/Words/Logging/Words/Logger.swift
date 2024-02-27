//
//  Logger.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Logger: AffixedWord
{
    public init()
    {
        super.init(roots: [Register()], suffixes: [Object()])
    }
}
