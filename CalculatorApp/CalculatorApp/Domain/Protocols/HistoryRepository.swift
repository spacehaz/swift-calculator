//
//  HistoryRepository.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 21.10.2026.
//

nonisolated protocol HistoryRepository: Sendable {
    func save(_ entry: HistoryEntry) async throws
    
//    newest first
    func fetchAll() async throws -> [HistoryEntry]
    

    func clear() async throws
}
