//
//  LengthRelated.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

public class LengthRelated: AffixedWord
{
    public init()
    {
        super.init(roots: [Long()], suffixes: [Property(), Adjective()])
    }
}
