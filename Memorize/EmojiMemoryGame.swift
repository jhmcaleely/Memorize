//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by John McAleely on 06/04/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<Character>
    @Published private(set) var theme: Theme<Color>
    
    private static var themes: [Theme<Color>] =
        [Theme(name: "Halloween", symbols: "π»ππ·πΈβοΈ", isRandomPreferred: true, color: Color.orange),
         Theme(name: "Faces", symbols: "ππ₯Έππππ", color: Color.yellow),
         Theme(name: "Sports", symbols: "β½οΈππβΎοΈπ₯π", isRandomPreferred: true, color: Color.green),
         Theme(name: "Sportswomen", symbols: "π§π½ββοΈβΉπΎββοΈπ€Ίπ€ΈπΎββοΈπ€ΎπΎββοΈ", color: Color.black),
         Theme(name: "Vehicles", symbols: "ππππππ", color: Color.gray),
         Theme(name: "Flags", symbols: "π³οΈββ§οΈπ³οΈβππ¬π§πΈπͺπΊπ³", color: Color.red)]
    
    private static func selectTheme() -> Theme<Color> {
        themes[Int.random(in: themes.indices)]
    }
    
    private static func createMemoryGame(with theme: Theme<Color>) -> MemoryGame<Character> {
        return MemoryGame<Character>(numberOfPairsOfCards: theme.chooseCardCount())
        { pairIndex in
            let character = theme.symbols.index(theme.symbols.startIndex, offsetBy: pairIndex)
            return theme.symbols[character]
        }
    }
    
    init() {
        let newTheme = EmojiMemoryGame.selectTheme()
        theme = newTheme
        game = EmojiMemoryGame.createMemoryGame(with: newTheme)
    }
    
    // MARK: Access to the Model

    var cards: Array<MemoryGame<Character>.Card> {
        game.cards
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<Character>.Card) {
        game.choose(card: card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.selectTheme()
        game = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
