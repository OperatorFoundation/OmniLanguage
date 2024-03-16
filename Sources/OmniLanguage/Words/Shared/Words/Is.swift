//
//  Is.swift
//
//
//  Created by Dr. Brandon Wiley on 3/1/24.
//

import Foundation

import Text

public class Is: AffixedWord
{
    public init()
    {
        super.init(roots: [Be()], suffixes: [PresentTenseVerb()])
    }
}

