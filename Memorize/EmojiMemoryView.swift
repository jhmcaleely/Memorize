//
//  EmojiMemoryView.swift
//  Memorize
//
//  Created by John McAleely on 05/04/2021.
//

import SwiftUI

struct EmojiMemoryView: View {
    var emojiGame: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(emojiGame.cards.count > 4 ? .body : .largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryView(emojiGame: EmojiMemoryGame())
    }
}
