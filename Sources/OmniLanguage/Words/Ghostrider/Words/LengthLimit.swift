//
//  LengthLimit.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

public class LengthLimit: SingletonWord
{
    public init()
    {
        super.init(spelling: Bundle.main.localizedString(forKey: "bounds", value: nil, table: nil).text, glyphs: "|⟷|")
    }
}
