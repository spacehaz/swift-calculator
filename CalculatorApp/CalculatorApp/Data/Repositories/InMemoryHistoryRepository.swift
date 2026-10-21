//
//  InMemoryHistoryRepository.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 21.10.2026.
//

import Foundation

actor InMemoryHistoryRepository: HistoryRepository {
    private var historyEntries: [HistoryEntry] = []
    
    func save(_ entry: HistoryEntry) async throws {
        historyEntries.insert(entry, at: 0)
    }
    
    func fetchAll() async throws -> [HistoryEntry] {
        return self.historyEntries
    }
    
    
    func clear() async throws {
        self.historyEntries = []
    }
}
