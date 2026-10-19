//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//
import SwiftUI
import CalculatorCore


enum CalculatorButtonStyle {
    case digit
    case operation
    case function
}

struct CalculatorButton: View {
    let title: String
    let style: CalculatorButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 60, height: 60)
                .font(.headline)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue)
                )
        }
    }
}

extension Key {
    var buttonStyle: CalculatorButtonStyle {
        switch self {
            case .digit: .digit
            case .operation: .operation
            case .decimalPoint: .function
            case .equals: .function
            case .allClear: .function
        }
    }
    
    var buttonLabel: String {
        switch self {
            case .digit(let value): "\(value.rawValue)"
            case .operation(let operation):
                switch (operation) {
                    case .add: "+"
                    case .divide: "/"
                    case .subtract: "-"
                    case .multiply: "*"
                }
            case .decimalPoint: "."
            case .equals: "="
            case .allClear: "AC"
        }
    }
}


#Preview {
    let key1: Key = .digit(.one)
    let keyAC: Key = .allClear

    VStack {
        CalculatorButton(
            title: key1.buttonLabel,
            style: key1.buttonStyle
        ) {}
        CalculatorButton(
            title: keyAC.buttonLabel,
            style: keyAC.buttonStyle
        ) {}
    }
    
}
