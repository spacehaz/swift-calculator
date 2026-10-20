//
//  Key+Presentation.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 20.10.2026.
//
import CalculatorCore

extension Key {
    var buttonStyle: CalculatorButtonStyle {
        switch self {
            case .digit: .digit
            case .operation: .operation
            case .decimalPoint: .digit
            case .equals: .operation
            case .allClear: .function
        }
    }
    
    var buttonLabel: String {
        switch self {
            case .digit(let value): "\(value.rawValue)"
            case .operation(let operation):
                switch (operation) {
                    case .add: "+"
                    case .divide: "÷"
                    case .subtract: "−"
                    case .multiply: "×"
                }
            case .decimalPoint: "."
            case .equals: "="
            case .allClear: "AC"
        }
    }
}
