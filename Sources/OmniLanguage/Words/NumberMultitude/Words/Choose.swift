//
//  Choose.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

public class Choose: AffixedWord
{
    public init()
    {
        super.init(roots: [Choice()], suffixes: [Imperative()])
    }
}
