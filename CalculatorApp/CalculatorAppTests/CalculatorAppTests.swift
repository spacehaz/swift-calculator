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
    @Test("Testing historyEntries", arguments: expressionTestValues)
    func expressionValuesTest(keys: [Key], expected: [String]) {
        let repository = InMemoryHistoryRepository()
        let viewModel = CalculatorViewModel(history: repository)
        
        for item in keys {
            viewModel.press(item)
        }
        let historyExpressions = viewModel.historyEntries.map({ "\($0.expression) = \($0.result)"})
        #expect(historyExpressions == expected)
    }
    
    
    typealias Step = (key: Key, beforePress: String, afterPress: String, hasError: Bool)
    static let historyRecorderCases: [(operationValues: [Step], expected: String)] = [
        (
            operationValues: [
                (key: .digit(.three),  beforePress: "", afterPress: "3", hasError: false),
                (key: .operation(.add),  beforePress: "3", afterPress: "3", hasError: false),
                (key: .equals, beforePress: "3", afterPress: "6", hasError: false)
            ],
            expected: "3 + 3"
        )
    ]
    @Test("Testing HistoryRecorder", arguments: historyRecorderCases)
    func historyRecorderTest(
        operationValues: [Step],
        expected: String
    ) {
        var historyRecorder = HistoryRecorder()
        
        var record: HistoryEntry?
        for values in operationValues {
            record = historyRecorder.createRecord(
                values.key,
                beforePress: values.beforePress,
                afterPress: values.afterPress,
                hasError: values.hasError
            )
        }
        
        #expect(record?.expression == expected)

    }
}
