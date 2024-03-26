//
//  ListenCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class ListenCommand: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "listens", value: nil, table: nil).text, glyphs: Listen().glyphs)
    }
}
