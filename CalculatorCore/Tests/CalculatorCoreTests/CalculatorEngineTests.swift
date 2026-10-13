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

@Test("DecimalPoint input", arguments: [
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

