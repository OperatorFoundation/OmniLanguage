//
//  Flow.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

public class Flow: AffixedWord
{
    public init()
    {
        super.init(roots: [Flowing()], suffixes: [Object()])
    }
}
