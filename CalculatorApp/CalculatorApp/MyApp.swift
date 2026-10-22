import SwiftUI

@main struct MyApp: App {
    @State private var viewModel: CalculatorViewModel
    
    init () {
        let historyRepository = InMemoryHistoryRepository()
        viewModel = CalculatorViewModel(history: historyRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
