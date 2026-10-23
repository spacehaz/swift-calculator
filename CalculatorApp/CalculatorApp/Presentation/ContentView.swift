import SwiftUI
import CalculatorCore

struct ContentView: View {
    private var viewModel: CalculatorViewModel
    @State private var isHistoryPresented = false
    
    init (viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    
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
            HStack {
                Button {
                    isHistoryPresented = true
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                }
                Spacer()
            }
            .padding(.horizontal)
            Spacer()

            CalculatorDisplay(text: viewModel.displayText)
            Grid {
                ForEach(buttons.indices, id: \.self) { index in
                    
                    GridRow {
                        ForEach(buttons[index], id: \.self) { key in
                            CalculatorButton(
                                title: key.buttonLabel,
                                style: key.buttonStyle,
                                isSquare: key.columnsCount == 1
                            ) {
                                withAnimation { viewModel.press(key) }
                            }
                            .gridCellColumns(key.columnsCount)

                        }
                    }
                }
            }
            .padding()
            .fixedSize(horizontal: false, vertical: true) 
            .sheet(isPresented: $isHistoryPresented) {
                HistoryPage(entries: viewModel.historyEntries, onClear: {
                    viewModel.clearAll()
                })
            }
            
        }
        .frame(maxHeight: .infinity)
        .background(.black)
    }
}
