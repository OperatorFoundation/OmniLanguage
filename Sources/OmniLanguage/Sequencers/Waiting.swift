//
//  Waiting.swift
//
//
//  Created by Dr. Brandon Wiley on 3/18/24.
//

import Foundation

import Text
import Time

public class Waiting: Sequencer
{
    public let timeout: TimeDuration

    public init(_ timeout: TimeDuration = TimeDuration(resolution: .seconds, ticks: 60 * 2)) // Defaults to 2 minutes.
    {
        self.timeout = timeout
    }
}

extension Waiting: CustomStringConvertible
{
    public var description: String
    {
        return Awaiting().description
    }
}

extension Waiting
{
    public var glyphs: Text
    {
        return "\(TimeLimit().glyphs) \(self.timeout.glyphs)".text
    }
}
