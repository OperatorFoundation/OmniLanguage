//
//  With.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

import Text

public class With: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "with", value: nil, table: nil).text, glyphs: "∘")
    }
}
