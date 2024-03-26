//
//  Logger.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class Logger: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "logger", value: nil, table: nil).text, glyphs: "\\□")
    }
}
