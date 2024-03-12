//
//  Indifferent.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

public class Indifferent: Sequencer
{
    public init(){}
}

extension Indifferent: CustomStringConvertible
{
    public var description: String
    {
        return Also().description
    }
}
