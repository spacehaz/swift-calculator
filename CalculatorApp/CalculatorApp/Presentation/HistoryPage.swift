//
//  HistoryPage.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 23.10.2026.
//

import SwiftUI

struct HistoryPage: View {
    let entries: [HistoryEntry]
    let onClear: () -> Void
    @State private var isDeleting: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    ContentUnavailableView("No history yet", systemImage: "clock")
                } else {
                    List {
                        ForEach(entries) { item in
                            Text("\(item.expression) = \(item.result)")
                        }
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Clear", role: .destructive) {
                        self.isDeleting = true
                    }
                    .disabled(entries.isEmpty)
                    .confirmationDialog("History clear action", isPresented: $isDeleting) {
                        Button("Clear History", role: .destructive) {
                            onClear()
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure?")
                    }
                }
                
                ToolbarItem (placement: .confirmationAction) {
                    Button("Return", role: .close) {
                        dismiss()
                    }
                }
            }
            
        }
    }
}

#Preview {
    let entries = [HistoryEntry(expression: "1 + 1", result: "2" )]
    HistoryPage(entries: entries, onClear: {})
}
