//
//  DisplayText.swift
//  CalculatorApp
//
//  Created by Hazo Baykulov on 19.10.2026.
//

import SwiftUI

struct DisplayText: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
            .frame(
                maxWidth: .infinity,
                maxHeight: 100,
                alignment: .trailing
            )
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
                    .fill(Color.red)
                    .strokeBorder(
                        .green,
                        lineWidth: 5
                    )
            )
            .font(.system(size: 80, weight: .light))
            .bold()
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            
    }
}

#Preview {
    VStack {
        DisplayText(text: "HelloHelloHelloHelloHelloHelloHello")
        DisplayText(text: "Hello")


    }
}
