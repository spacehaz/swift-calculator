//
//  CalculatorAppTests.swift
//  CalculatorAppTests
//
//  Created by Hazo Baykulov on 21.10.2026.
//

import Testing
@testable import CalculatorApp
import CalculatorCore

@MainActor struct CalculatorAppTests {
    static let expressionTestValues: [(keys: [Key], expected: [String])] = [
        (keys: [
            .digit(.one),
            .digit(.two),
            .operation(.add),
            .digit(.three),
            .equals
        ], expected: ["12 + 3 = 15"]),
        (keys: [
            .digit(.one),
            .digit(.two),
            .operation(.add),
            .digit(.three),
            .equals,
            .equals
        ], expected: ["12 + 3 = 15"]),
        (keys: [
            .digit(.one),
            .operation(.add),
            .operation(.subtract),
            .digit(.one),
            .equals,
        ], expected: ["1 − 1 = 0"]),
        
        (keys: [
            .digit(.one),
            .operation(.add),
            .digit(.three),
            .operation(.multiply),
            .digit(.two),
            .equals,
        ], expected: ["1 + 3 × 2 = 8"]),
        
        (keys: [
            .digit(.five),
            .operation(.divide),
            .digit(.zero),
            .equals,
        ], expected: []),
        
        (keys: [
            .digit(.five),
            .operation(.divide),
            .digit(.zero),
            .operation(.add),
            .digit(.one),
            .equals,
        ], expected: []),
        
        (keys: [
            .digit(.seven),
            .equals,
        ], expected: [])
        
    ]
    
    @Test("Expression test values", arguments: expressionTestValues)
    
    func expressionValuesTest(keys: [Key], expected: [String]) async throws {
        let repository = InMemoryHistoryRepository()
        let viewModel = CalculatorViewModel(history: repository)
        
        for item in keys {
            viewModel.press(item)
        }
        let historyExpressions = viewModel.historyEntries.map({ "\($0.expression) = \($0.result)"})
        #expect(historyExpressions == expected)
    }
}
