//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Daydream

public protocol Effect: CustomStringConvertible, Codable
{
    var group: EffectGroup { get }
}

public protocol Bindable
{
    var binding: Type { get }
}

public protocol Refinable
{
    var refinement: Type { get }
}
