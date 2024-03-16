//
//  Sequencer.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

import Text

public protocol Sequencer: CustomStringConvertible
{
    var glyphs: Text { get }
}
