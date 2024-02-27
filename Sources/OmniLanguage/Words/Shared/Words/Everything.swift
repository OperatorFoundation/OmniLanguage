//
//  Everything.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Everything: AffixedWord
{
    public init()
    {
        super.init(prefixes: [This()], suffixes: [Object()])
    }
}
