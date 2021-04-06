//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by John McAleely on 06/04/2021.
//

import SwiftUI

class EmojiMemoryGame {
    private var game: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex] }
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
