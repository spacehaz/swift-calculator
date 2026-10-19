import SwiftUI
import Playgrounds
import CalculatorCore

struct ContentView: View {
    @State private var viewModel = CalculatorViewModel()
    
    var body: some View {
        DisplayText(text: viewModel.displayText)
    }
}

#Preview {
    ContentView()
}
