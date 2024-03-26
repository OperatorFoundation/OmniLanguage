//
//  Writing.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

public class Writing: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "writing", value: nil, table: nil).text, glyphs: "\\")
    }
}
