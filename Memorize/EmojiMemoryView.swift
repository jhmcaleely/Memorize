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
                    withAnimation(.linear) {
                        emojiGame.choose(card: card)
                    }
                }
                .padding()
            }
            .padding()
            .foregroundColor(emojiGame.theme.color)
            Button("New Game") {
                withAnimation(.easeInOut) {
                    emojiGame.newGame()
                }
            }
        }
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<Character>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: -animatedBonusRemaining*360-90),
                            clockwise: true)
                            .onAppear() {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: -card.bonusRemaining*360-90),
                            clockwise: true)
                        
                    }
                }
                .padding(progressPadding)
                .opacity(progressOpacity)
                .transition(.scale)
                Text(String(card.content))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ?
                                Animation.linear.repeatForever(autoreverses: false)
                                : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
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
