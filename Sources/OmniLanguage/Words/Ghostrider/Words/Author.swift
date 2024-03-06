//
//  Author.swift
//
//
//  Created by Dr. Brandon Wiley on 3/1/24.
//

import Foundation

public class Author: AffixedWord
{
    public init()
    {
        super.init(roots: [Authorial()], suffixes: [Object()])
    }
}
