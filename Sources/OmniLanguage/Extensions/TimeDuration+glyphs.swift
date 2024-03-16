//
//  TimeDuration+glyphs.swift
//
//
//  Created by Dr. Brandon Wiley on 3/15/24.
//

import Foundation

import Text
import Time

extension TimeDuration
{
    public var glyphs: Text
    {
        switch self.resolution
        {
            case .milliseconds:
                let result: MutableText = ""
                result.becomeAppended(self.ticks.string.text)
                result.becomeAppended(" ")
                result.becomeAppended(Milliseconds().glyphs)

                return result.text

            case .nanoseconds:
                let result: MutableText = ""
                result.becomeAppended(self.ticks.string.text)
                result.becomeAppended(" ")
                result.becomeAppended(Nanoseconds().glyphs)

                return result.text

            case .seconds:
                let result: MutableText = ""
                result.becomeAppended(self.ticks.string.text)
                result.becomeAppended(" ")
                result.becomeAppended(Seconds().glyphs)

                return result.text
        }
    }
}
