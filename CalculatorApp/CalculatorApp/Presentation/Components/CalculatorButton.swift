//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//
import SwiftUI
import UIKit

enum CalculatorButtonStyle {
    case digit
    case operation
    case function
    
    var background: Color {
        switch self {
            case .digit: .darkGrey
            case .function: .lightGrey
            case .operation: .accent
        }
    }
    var foreground: Color {
        switch self {
            case .function: .black
            case .operation: .white
            case .digit: .white
        }
    }
    
    var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
            case .function: .heavy
            case .operation: .medium
            case .digit: .light
        }
    }
}



struct CalculatorButton: View {
    let title: String
    let style: CalculatorButtonStyle
    var isSquare: Bool = true
    let action: () -> Void
    
    var buttonShape: some View {
        Text(title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.headline)
            .foregroundStyle(style.foreground)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(style.background)
            )
    }
    
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: style.hapticStyle).impactOccurred()
            action()
        } label: {
            if (isSquare) {
                buttonShape
                    .aspectRatio(1, contentMode: .fit)
            } else {
                buttonShape
            }
        }
    }
}


#Preview {
    VStack {
        CalculatorButton(
            title: "7",
            style: .digit
        ) {}
        
        CalculatorButton(
            title: "+",
            style: .operation
        ) {}
        
        CalculatorButton(
            title: "AC",
            style: .function
        ) {}
    }
    
}
