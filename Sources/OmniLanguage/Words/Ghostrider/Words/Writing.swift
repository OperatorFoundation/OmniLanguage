//
//  Writing.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

public class Writing: AffixedWord
{
    public init()
    {
        super.init(roots: [Textual()], suffixes: [Object()], glyphs: "\\")
    }
}
