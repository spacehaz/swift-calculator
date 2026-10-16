import Testing
import CalculatorCore


func display(after keys: [Key]) -> String {
    var engine = CalculatorEngine()
    
    for key in keys {
        engine.press(key)
    }
    
    return engine.display
}

@Test("New calculator shows 0") func newCalculatorShowsZero() {
    let engine = CalculatorEngine()
    let initialValue = engine.display
    #expect(initialValue == "0")
}


@Test("Digit input", arguments: [
    (keys: [Key.digit(7)], expected: "7"),
    (keys: [.digit(1), .digit(2)], expected: "12"),
    (keys: [.digit(0), .digit(0), .digit(7)], expected: "7"),
])
func pressedDigits(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}

@Test("Decimal point input", arguments: [
    (keys: [Key.digit(1), .decimalPoint, .digit(7)], expected: "1.7"),
    (keys: [.decimalPoint], expected: "0."),
    (keys: [.decimalPoint, .digit(5)], expected: "0.5"),
    (keys: [.digit(1), .decimalPoint, .digit(7), .decimalPoint], expected: "1.7")
])
func pressedDecimalPointWithDigits(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}


@Test("Add operation input", arguments: [
    (keys: [Key.digit(1), Key.operation(.add),  .digit(7)], expected: "7"),
    (keys: [Key.digit(1), Key.operation(.add)], expected: "1"),
    (keys: [Key.digit(1), Key.operation(.add),  .digit(7), .digit(7)], expected: "77"),
    (keys: [Key.digit(1), Key.operation(.add),  .digit(7), .digit(7), .equals], expected: "78"),
    (keys: [Key.digit(1), Key.operation(.add),  .digit(1), .digit(1), Key.operation(.add), .digit(1)], expected: "1"),
    (keys: [Key.digit(1), Key.operation(.add),  .digit(1), .digit(1), Key.operation(.add)], expected: "12"),
    (keys: [Key.digit(5), Key.operation(.add),  .decimalPoint], expected: "0."),
    (keys: [Key.digit(1), Key.operation(.add),  .digit(2), .equals, .digit(5)], expected: "5"),
    (keys: [Key.digit(1), Key.operation(.add),  Key.operation(.add)], expected: "1"),
    (keys: [Key.digit(7), .equals,  .operation(.add), Key.digit(1), .equals], expected: "8")
])
func pressedAddOperation(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}


@Test("Additional add operation input", arguments: [
    (keys: [.operation(.add), Key.digit(5),  .operation(.add), Key.digit(3), .equals], expected: "8"),
    (keys: [Key.digit(1), .decimalPoint, Key.digit(5), .operation(.add), Key.digit(1), .equals], expected: "2.5"),
    (keys: [Key.digit(1), .operation(.add), Key.digit(2), .equals, .decimalPoint], expected: "0."),
    (keys: [Key.digit(7), .equals, .decimalPoint, Key.digit(5)], expected: "0.5"),
    (keys: [
        Key.digit(1),
        .operation(.add),
        Key.digit(2),
        .equals,
        Key.digit(7),
        .equals,
        .operation(.add),
        Key.digit(1),
        .equals
    ], expected: "8"),
    (keys: [
        Key.digit(7),
        .equals,
        Key.digit(5),
    ], expected: "5"),
])
func pressedAdditionalAddOperation(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}

@Test("Substract operation input", arguments: [
    (keys: [Key.digit(5),  .operation(.subtract), Key.digit(3), .equals], expected: "2"),
    (keys: [Key.digit(5),  .operation(.add), Key.digit(2), .operation(.subtract), Key.digit(3), .equals], expected: "4"),
    (keys: [.operation(.subtract), Key.digit(5), .equals], expected: "-5"),
    (keys: [Key.digit(3), .operation(.subtract), Key.digit(5), .equals], expected: "-2"),
    (keys: [Key.digit(5), .operation(.add), .operation(.subtract), Key.digit(3), .equals], expected: "2"),
    (keys: [Key.digit(0), .decimalPoint, Key.digit(3), .operation(.subtract), Key.digit(0), .decimalPoint, Key.digit(1), .equals], expected: "0.2"),
])
func pressedSubstractOperation(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}
