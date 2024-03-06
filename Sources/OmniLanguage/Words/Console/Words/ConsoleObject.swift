//
//  ConsoleObject.swift
//
//
//  Created by Dr. Brandon Wiley on 3/1/24.
//

import Foundation

public class ConsoleObject: AffixedWord
{
    public static let instance: ConsoleObject = ConsoleObject()

    public init()
    {
        super.init(roots: [Console()], suffixes: [Object()])
    }
}
