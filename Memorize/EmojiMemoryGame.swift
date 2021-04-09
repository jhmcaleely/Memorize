//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by John McAleely on 06/04/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>
    @Published var theme: Theme<Color>
    
    static var themes: [Theme<Color>] =
        [Theme(name: "Halloween", symbols: "👻🎃🕷🕸☃️", isRandomPreferred: true, color: Color.orange),
         Theme(name: "Faces", symbols: "😀🥸😍😂😛😇", color: Color.yellow),
         Theme(name: "Sports", symbols: "⚽️🏀🏈⚾️🥏🏓", isRandomPreferred: true, color: Color.green),
         Theme(name: "Sportswomen", symbols: "🧘🏽‍♀️⛹🏾‍♀️🤺🤸🏾‍♀️🤾🏾‍♀️", color: Color.black),
         Theme(name: "Vehicles", symbols: "🚗🚕🚐🏎🚜🚎", color: Color.gray),
         Theme(name: "Flags", symbols: "🏳️‍⚧️🏳️‍🌈🇬🇧🇸🇪🇺🇳", color: Color.red)]
    
    static func selectTheme() -> Theme<Color> {
        themes[Int.random(in: themes.indices)]
    }
    
    static func createMemoryGame(with theme: Theme<Color>) -> MemoryGame<String> {
        let emojis: Array<String> = theme.symbols.map() { item in String(item) }
        return MemoryGame<String>(numberOfPairsOfCards: theme.chooseCardCount()) { pairIndex in emojis[pairIndex] }
    }
    
    init() {
        let newTheme = EmojiMemoryGame.selectTheme()
        theme = newTheme
        game = EmojiMemoryGame.createMemoryGame(with: newTheme)
    }
    
    // MARK: Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.selectTheme()
        game = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
