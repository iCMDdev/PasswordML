//
//  ScoreGaugeView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 06.04.2023.
//

import SwiftUI

/// A circular gage, used to display a password's strength on a scale from 0 to 100, where 100 is the safest
struct ScoreGaugeView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var value: Double
    let gradient = Gradient(colors: [.cyan, .blue, .purple, .orange, .pink, .red])
    
    var body: some View {
        ZStack {
            Gauge(value: value, in: 0...1) {
                Image(systemName: "key.horizontal.fill")
                    .imageScale(.large)
            } currentValueLabel: {
                Text("\(Double(value)*100, specifier: "%.0f")")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(gradient)
            .padding()
            Gauge(value: value, in: 0...1) {
                Image(systemName: "key.horizontal.fill")
                    .imageScale(.large)
            } currentValueLabel: {
                Text("\(Double(value)*100, specifier: "%.0f")")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(gradient)
            .blur(radius: 10).opacity(colorScheme == .light ? 0.5 : 0.3)
            .padding()
        }
    }
}

struct ScoreGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreGaugeView(value: Binding(get: {
            return 0.5
        }, set: { _, _ in
            
        }))
    }
}
