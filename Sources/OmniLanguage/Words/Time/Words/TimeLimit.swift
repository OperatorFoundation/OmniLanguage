//
//  TimeLimit.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

public class TimeLimit: CompoundWord
{
    public init()
    {
        super.init(parts: [Time(), Limitation()], glyphs: "|◷|")
    }
}
