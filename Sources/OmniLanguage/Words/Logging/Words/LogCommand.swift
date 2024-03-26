//
//  LogCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class LogCommand: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "writes", value: nil, table: nil).text, glyphs: "\\")
    }
}
