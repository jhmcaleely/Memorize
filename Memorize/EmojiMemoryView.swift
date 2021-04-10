//
//  EmojiMemoryView.swift
//  Memorize
//
//  Created by John McAleely on 05/04/2021.
//

import SwiftUI

struct EmojiMemoryView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(emojiGame.theme.name) Score: \(emojiGame.score)")
            Grid(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiGame.choose(card: card)
                }
                .padding()
            }
            .padding()
            .foregroundColor(emojiGame.theme.color)
            Button("New Game") {
                emojiGame.newGame()
            }
        }
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<Character>.Card
    
    var body: some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90),
                    endAngle: Angle(degrees: 110-90),
                    clockwise: true)
                    .padding(progressPadding)
                    .opacity(progressOpacity)
                Text(String(card.content))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: Drawing Parameters
    
    private let progressPadding: CGFloat = 4
    private let progressOpacity = 0.4
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards.first!)
        return EmojiMemoryView(emojiGame: game)
    }
}
