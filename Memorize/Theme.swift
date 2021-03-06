//
//  Theme.swift
//  Memorize
//
//  Created by John McAleely on 09/04/2021.
//

import Foundation

struct Theme<ColorType> {
    var name: String
    var symbols: String
    var isRandomPreferred: Bool = false
    var color: ColorType
    
    let minCardCount = 2
    var maxCardCount: Int {
        symbols.count
    }
    var preferredCardCount: Int? {
        isRandomPreferred ? nil : maxCardCount
    }
    
    func chooseCardCount() -> Int {
        preferredCardCount ?? Int.random(in: minCardCount...maxCardCount)
    }
}
