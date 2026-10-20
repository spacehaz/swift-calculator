//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//
import SwiftUI

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
}



struct CalculatorButton: View {
    let title: String
    let style: CalculatorButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .font(.headline)
                .foregroundStyle(style.foreground)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(style.background)
                )
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
