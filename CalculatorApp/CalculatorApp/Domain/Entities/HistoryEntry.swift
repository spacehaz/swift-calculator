//
//  HistoryEntry.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 21.10.2026.
//
import Foundation

nonisolated struct HistoryEntry: Identifiable, Sendable, Equatable {
    let id: UUID
    let expression: String
    let result: String
    let date: Date
    
    
    init(
        id: UUID = UUID(),
        expression: String,
        result: String,
        date: Date = .now
    ) {
        self.id = id
        self.expression = expression
        self.result = result
        self.date = date
    }
}
