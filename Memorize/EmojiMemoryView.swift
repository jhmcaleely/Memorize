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
            Text(emojiGame.theme.name)
            Grid(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiGame.choose(card: card)
                }
                .padding()
            }
            .padding()
            .foregroundColor(emojiGame.theme.colour)
            Button("New Game") {
                emojiGame.newGame()
            }
        }
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: egdeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: Drawing Parameters
    
    let cornerRadius: CGFloat = 10
    let egdeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.55
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryView(emojiGame: EmojiMemoryGame())
    }
}
