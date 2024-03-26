//
//  Author.swift
//
//
//  Created by Dr. Brandon Wiley on 3/1/24.
//

import Foundation

public class Author: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "author", value: nil, table: nil).text, glyphs: Authorial().glyphs)
    }
}
