//
//  Blocking.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

public class Blocking: Sequencer
{
}

extension Blocking: CustomStringConvertible
{
    public var description: String
    {
        return Awaiting().description
    }
}
