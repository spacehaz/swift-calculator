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
        keyLabel(self)
    }
    
    var columnsCount: Int {
        switch self {
        case .digit: 1
        case .operation: 1
        case .decimalPoint: 1
        case .equals: 2
        case .allClear: 3
        }
    }
}
