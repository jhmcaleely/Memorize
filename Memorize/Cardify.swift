//
//  Cardify.swift
//  Memorize
//
//  Created by John McAleely on 10/04/2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
    private let cornerRadius: CGFloat = 10
    private let egdeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.50
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: egdeLineWidth)
                    content
                }
                .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                    .opacity(isFaceUp ? 0 : 1)
            }
            .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
            .font(Font.system(size: fontSize(for: geometry.size)))
            .rotation3DEffect(
                Angle(degrees: rotation),
                axis: (x: 0.0, y: 1.0, z: 0.0))
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
