//
//  Time.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Time: AffixedWord
{
    public init()
    {
        super.init(roots: [Temporal()], suffixes: [Object()])
    }
}
