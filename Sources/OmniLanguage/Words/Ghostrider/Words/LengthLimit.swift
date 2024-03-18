//
//  LengthLimit.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

public class LengthLimit: CompoundWord
{
    public init()
    {
        super.init(parts: [LengthRelated(), Limitation()], glyphs: "|⟷|")
    }
}
