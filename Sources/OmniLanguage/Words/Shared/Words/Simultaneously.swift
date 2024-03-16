//
//  Simultaneously.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Text

public class Simultaneously: AffixedWord
{
    public init()
    {
        super.init(roots: [Same(), Temporal()], suffixes: [Adverb()])
    }
}

