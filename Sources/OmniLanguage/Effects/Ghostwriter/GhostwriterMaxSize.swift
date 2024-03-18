//
//  MaxSize.swift
//
//
//  Created by Joshua Clark on 3/18/24.
//

import Foundation

public class MaxSize: Refinement
{
    public init(_ value: Value)
    {
        super.init(name: "maxSize", glyphs: LengthLimit().glyphs, value: value)
    }
}
