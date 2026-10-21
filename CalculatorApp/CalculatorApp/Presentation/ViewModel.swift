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
    private var history: HistoryRepository
    private(set) var historyEntries: [HistoryEntry] = []
    private(set) var lastKeyWasOperation: Bool = false
    private var currentEntry: String = ""
    
    init (history: HistoryRepository) {
        self.history = history
    }
    
    var displayText: String {
        if calculatorEngine.error != nil { return "Error" }
            return calculatorEngine.display
    }
    
    
    func press (_ key: Key) {
        let beforePress: String = calculatorEngine.display
        
        calculatorEngine.press(key)
        
        
        switch key {
            case .digit, .decimalPoint:
                lastKeyWasOperation = false
                break
            case .operation:
               if calculatorEngine.error != nil {
                    // e.g. `5 ÷ 0 +`: the chain failed, nothing from it belongs in history
                    currentEntry = ""
                    lastKeyWasOperation = false
                    break
                }

                let symbol = key.buttonLabel

                if lastKeyWasOperation {
                    // operator change (`5 + −`): swap the last symbol, the operand is already there
                    currentEntry.removeLast()
                    currentEntry += symbol
                } else if currentEntry.isEmpty {
                    // first operator of a new expression: `"2 +"`
                    currentEntry = "\(beforePress) \(symbol)"
                } else {
                    // chaining: `"2 +"` becomes `"2 + 3 ×"`
                    currentEntry += " \(beforePress) \(symbol)"
                }

                lastKeyWasOperation = true
            case .equals:
                defer {
                    self.currentEntry = ""
                    self.lastKeyWasOperation = false
                } // will happen anyway
                guard !currentEntry.isEmpty else { break }
                guard calculatorEngine.error == nil else { break }
                let expression = "\(currentEntry) \(beforePress)"
                let newEntry = HistoryEntry(
                    expression: expression,
                    result: calculatorEngine.display
                )
                historyEntries.insert(newEntry, at: 0)
                Task {
                    try? await self.history.save(newEntry)
                }
            case .allClear:
                self.lastKeyWasOperation = false
                self.currentEntry = ""
        }
    }
}
