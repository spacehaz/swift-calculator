public struct CalculatorEngine: Sendable {
    public private(set) var display: String = "0"
    
    public init() {
    }


    public mutating func press(_ key: Key) {
        
        switch key {
            case .digit(let value):
                if display == "0" {
                    self.display = String(value)
                } else {
                    self.display += String(value)
                }
            case .decimalPoint:
                if !display.contains(".") {
                    self.display += "."
                }
        }
    }
}
