import SwiftUI
import CalculatorCore

struct ContentView: View {
    @State private var viewModel = CalculatorViewModel()
    
    let buttons: [[Key]] = [
        [.allClear, .operation(.divide)],
        [
            .digit(.seven),
            .digit(.eight),
            .digit(.nine),
            .operation(.multiply)
        ],
        [
            .digit(.four),
            .digit(.five),
            .digit(.six),
            .operation(.subtract)
        ],
        [
            .digit(.one),
            .digit(.two),
            .digit(.three),
            .operation(.add)
        ],
        [
            .digit(.zero),
            .decimalPoint,
            .equals
        ]
    ]
    
    var body: some View {
        VStack {
            CalculatorDisplay(text: viewModel.displayText)
            Grid {
                ForEach(buttons.indices, id: \.self) { index in
                    
                    GridRow {
                        ForEach(buttons[index], id: \.self) { key in
                            CalculatorButton(title: key.buttonLabel, style: key.buttonStyle) {
                                withAnimation { viewModel.press(key) }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
        }
        .frame(maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}
