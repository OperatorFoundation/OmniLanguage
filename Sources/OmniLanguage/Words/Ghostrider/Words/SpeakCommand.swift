//
//  SpeakCommand.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public class SpeakCommand: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "speaks", value: nil, table: nil).text, glyphs: Speak().glyphs)
    }
}
