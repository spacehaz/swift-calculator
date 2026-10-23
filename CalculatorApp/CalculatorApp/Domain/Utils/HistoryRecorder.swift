//
//  HistoryRecorder.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 22.10.2026.
//

import CalculatorCore

nonisolated struct HistoryRecorder {
    
    private(set) var lastKeyWasOperation: Bool = false
    private var currentEntry: String = ""
    
    mutating func createRecord (
        _ key: Key,
        beforePress: String,
        afterPress: String,
        hasError: Bool
    ) -> HistoryEntry? {
        var newHistoryEntry: HistoryEntry? = nil
        switch key {
            case .digit, .decimalPoint:
                self.lastKeyWasOperation = false
                break
            case .operation:
               if  hasError == true {
                    self.currentEntry = ""
                    self.lastKeyWasOperation = false
                    break
                }

                let symbol = keyLabel(key)

                if lastKeyWasOperation {
                    self.currentEntry.removeLast()
                    self.currentEntry += symbol
                } else if currentEntry.isEmpty {
                    // first operator of a new expression: `"2 +"`
                    self.currentEntry = "\(beforePress) \(symbol)"
                } else {
                    // chaining: `"2 +"` becomes `"2 + 3 ×"`
                    self.currentEntry += " \(beforePress) \(symbol)"
                }

                lastKeyWasOperation = true
            case .equals:
                defer {
                    self.currentEntry = ""
                    self.lastKeyWasOperation = false
                } // will happen anyway
                guard !currentEntry.isEmpty else { break }
                guard !hasError else { break }
                let expression = "\(currentEntry) \(beforePress)"
                newHistoryEntry = HistoryEntry(
                    expression: expression,
                    result: afterPress
                )
                            
            case .allClear:
                self.lastKeyWasOperation = false
                self.currentEntry = ""
        }
        
        return newHistoryEntry
        
    }
}
