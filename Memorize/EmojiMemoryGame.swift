//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by John McAleely on 06/04/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>
    var theme: Theme
    
    static var themes: [Theme] =
        [Theme(name: "Halloween", symbols: "👻🎃🕷🕸☃️", isRandomPreferred: true, colour: Color.orange),
         Theme(name: "Faces", symbols: "😀🥸😍😂😛😇", isRandomPreferred: false, colour: Color.yellow),
         Theme(name: "Sports", symbols: "⚽️🏀🏈⚾️🥏🏓", isRandomPreferred: true, colour: Color.green),
         Theme(name: "Sportswomen", symbols: "🧘🏽‍♀️⛹🏾‍♀️🤺🤸🏾‍♀️🤾🏾‍♀️", isRandomPreferred: false, colour: Color.black),
         Theme(name: "Vehicles", symbols: "🚗🚕🚐🏎🚜🚎", isRandomPreferred: false, colour: Color.gray),
         Theme(name: "Flags", symbols: "🏳️‍⚧️🏳️‍🌈🇬🇧🇸🇪🇺🇳", isRandomPreferred: false, colour: Color.red)]
    
    init() {
        theme = EmojiMemoryGame.themes[Int.random(in: EmojiMemoryGame.themes.indices)]
        let emojis: Array<String> = theme.symbols.map() { item in String(item) }
        let pairCount = theme.isRandomPreferred ? Int.random(in: 2...emojis.count) : emojis.count
        game = MemoryGame<String>(numberOfPairsOfCards: pairCount) { pairIndex in emojis[pairIndex] }
    }
    
    // MARK: Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
