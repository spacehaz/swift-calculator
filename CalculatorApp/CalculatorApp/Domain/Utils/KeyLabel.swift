//
//  KeyLabel.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 23.10.2026.
//
import CalculatorCore

nonisolated func keyLabel (_ key: Key) -> String {
    switch key {
        case .digit(let value): return "\(value.rawValue)"
        case .operation(let operation):
            switch (operation) {
            case .add: return "+"
            case .divide: return "÷"
            case .subtract: return "−"
            case .multiply: return "×"
            }
        case .decimalPoint: return "."
        case .equals: return "="
        case .allClear: return "AC"
    }
}
