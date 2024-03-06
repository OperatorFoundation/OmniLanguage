//
//  OmniCompiler.swift
//
//
//  Created by Dr. Brandon Wiley on 3/5/24.
//

import Foundation

import OmniLanguage
import Text

public protocol OmniCompiler
{
    func compile(_ name: Text, _ chain: EffectChain) throws -> Text
}
