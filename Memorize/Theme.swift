//
//  Theme.swift
//  Memorize
//
//  Created by John McAleely on 09/04/2021.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var symbols: String
    var isRandomPreferred: Bool = false
    var colour: Color
    
    var maxCardCount: Int {
        symbols.count
    }
    var preferredCardCount: Int? {
        isRandomPreferred ? nil : maxCardCount
    }
    
    func chooseCardCount() -> Int {
        preferredCardCount ?? Int.random(in: 2...maxCardCount)
    }
}
