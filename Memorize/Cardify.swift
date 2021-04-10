//
//  Cardify.swift
//  Memorize
//
//  Created by John McAleely on 10/04/2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
    private let cornerRadius: CGFloat = 10
    private let egdeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.50
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: egdeLineWidth)
                    content
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
