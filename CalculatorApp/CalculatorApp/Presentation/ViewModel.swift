//
//  ViewModel.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//


import CalculatorCore
import Observation

@Observable @MainActor final class CalculatorViewModel {
    private var calculatorEngine = CalculatorEngine()
    
    var displayText: String {
        if calculatorEngine.error != nil { return "Error" }
            return calculatorEngine.display
    }
    
    
    func press (_ key: Key) {
        calculatorEngine.press(key)
    }
}
