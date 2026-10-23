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
    private var historyRecorder: HistoryRecorder = HistoryRecorder()
    private(set) var historyEntries: [HistoryEntry] = []
    
    
    init (history: HistoryRepository) {
        self.history = history
    }
    
    var displayText: String {
        if calculatorEngine.error != nil { return "Error" }
            return calculatorEngine.display
    }
    
    func clearHistory () {
        self.historyEntries = []
        Task { try? await history.clear() }
    }
    
    
    func press (_ key: Key) {
        let beforePress: String = calculatorEngine.display
        
        calculatorEngine.press(key)
        
        if let entry = historyRecorder.createRecord(
            key,
            beforePress: beforePress,
            afterPress: calculatorEngine.display,
            hasError: calculatorEngine.error != nil
        ) {
            historyEntries.insert(entry, at: 0)
            Task {
                try? await self.history.save(entry)
            }
        }
        
    }
}
