//
//  DayOfTheWeek.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class DayOfTheWeek: AffixedWord
{
    public init()
    {
        super.init(roots: [Week(), Day()], suffixes: [])
    }
}
