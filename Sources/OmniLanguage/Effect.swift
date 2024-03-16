//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/27/24.
//

import Foundation

import Daydream
import Text

public protocol Effect: CustomStringConvertible, Codable
{
    var group: EffectGroup { get }
    var glyphs: Text { get }
}

public protocol Bindable
{
    var binding: Type { get }
}

public protocol Refinable
{
    var refinement: Type { get }
}
