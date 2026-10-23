//
//  CalculatorDisplay.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//

import SwiftUI
import UIKit


struct CalculatorDisplay: View {
    let text: String
    
    var body: some View {
        Text(text)
            .frame(
                maxWidth: .infinity,
                alignment: .trailing
            )
            .padding()
            .font(.system(size: 80, weight: .light))
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .foregroundStyle(.white)
            .monospacedDigit()
            .contentTransition(.numericText())
            .textSelection(.enabled)
            .accessibilityLabel("Result")
            .contextMenu {
                Button("Copy", systemImage: "doc.on.doc") {
                    UIPasteboard.general.string = text
                }
                .disabled(text == "Error")
            }
            
    }
}

#Preview {
    VStack(alignment: .trailing) {
        CalculatorDisplay(text: "0")
        CalculatorDisplay(text: "-15")
        CalculatorDisplay(text: "Error")
        CalculatorDisplay(text: "0.3333333333333333333333333333333333333")
    }
    .background(.black)
}

