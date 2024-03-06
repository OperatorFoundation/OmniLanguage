//
//  Referent.swift
//
//
//  Created by Dr. Brandon Wiley on 2/26/24.
//

import Foundation

public enum Referent
{
    case effect(any Effect)
    case composition(Composition)
    case sequencer(Sequencer)
    
}
