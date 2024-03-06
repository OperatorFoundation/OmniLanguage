//
//  Refinement.swift
//
//
//  Created by Dr. Brandon Wiley on 2/29/24.
//

import Foundation

import Text

public struct Refinement: Composition
{
    public let name: Text
    public let value: Value
}

extension Refinement: CustomStringConvertible
{
    public var description: String
    {
        return "\(LikeThis().description) \"\(name) \(Is().description) \(value.description).\""
    }
}
