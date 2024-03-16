//
//  GhostwriterTimeout.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

public class Timeout: Refinement
{
    public init(_ value: Value)
    {
        super.init(name: "timeout", glyphs: TimeLimit().glyphs, value: value)
    }
}
