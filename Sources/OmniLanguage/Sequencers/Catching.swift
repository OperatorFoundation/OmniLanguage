//
//  Catching.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

public class Catching: Sequencer
{
    public init(){}
}

extension Catching: CustomStringConvertible
{
    public var description: String
    {
        return ErrorCatching().description
    }
}
