//
//  PassChartView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 15.04.2023.
//

import SwiftUI
import Charts

/// View that displays how a password's strength has variated with each change, using Swift Charts.
struct PassChartView: View {
    @Binding var data: [PasswordData]
    
    @Environment(\.layoutDirection) var layoutDirection
    
    @State var selectedElement: PasswordData? = nil
    
    func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> PasswordData? {
        // Borrowed from WWDC22 Swift Charts Sample Code
        // This function finds the nearest data point for the chart, when a user taps it.
        
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        if let value = proxy.value(atX: relativeXPosition) as Int? {
            // Find the closest date element.
            var minDistance: Int = .max
            var index: Int? = nil
            for dataIndex in data.indices {
                let nthDataDistance = data[dataIndex].change.distance(to: value)
                if abs(nthDataDistance) < minDistance {
                    minDistance = abs(nthDataDistance)
                    index = dataIndex
                }
            }
            if let index = index {
                return data[index]
            }
        }
        return nil
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Tap the chart to view info about a specific point.")
                    .font(.body.monospaced())
                    .frame(minHeight: 60)
                    .opacity(selectedElement == nil ? 1 : 0)
            Chart(data) {
                if data.count < 20 {
                    PointMark(
                        x: .value("Time", $0.change),
                        y: .value("Strength", $0.strength)
                    )
                    .foregroundStyle(.white)
                    .symbol(.circle)
                }
                
                LineMark(
                    x: .value("Time", $0.change),
                    y: .value("Strength", $0.strength)
                )
                .foregroundStyle(LinearGradient(colors: [.cyan, .blue, .purple, .orange, .pink, .red], startPoint: .bottom, endPoint: .top).opacity(0.8))
                .accessibilityLabel("Password change number: \($0.change)")
                .accessibilityValue("Estimated strength \($0.strength)")
                .interpolationMethod(.cardinal)
                
            }
            .chartXAxis(.hidden)
            .chartLegend(.hidden)
            .preferredColorScheme(.dark)
            .chartOverlay { proxy in
                GeometryReader { nthGeometryItem in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            SpatialTapGesture()
                                .onEnded { value in
                                    let element = findElement(location: value.location, proxy: proxy, geometry: nthGeometryItem)
                                    if selectedElement?.change == element?.change {
                                        // If tapping the same element, clear the selection.
                                        selectedElement = nil
                                    } else {
                                        selectedElement = element
                                    }
                                }
                                .exclusively(
                                    before: DragGesture()
                                        .onChanged { value in
                                            selectedElement = findElement(location: value.location, proxy: proxy, geometry: nthGeometryItem)
                                        }
                                )
                        )
                }
            }
            Spacer()
        }
            .chartBackground { proxy in
                ZStack(alignment: .topLeading) {
                    GeometryReader { nthGeoItem in
                        if let selectedElement = selectedElement {
                            let midStartPositionX = proxy.position(forX: selectedElement.change) ?? 0

                            let lineX = layoutDirection == .rightToLeft ? nthGeoItem.size.width - midStartPositionX : midStartPositionX
                            let lineHeight = nthGeoItem[proxy.plotAreaFrame].maxY
                            let boxWidth: CGFloat = 200
                            let boxOffset = max(0, min(nthGeoItem.size.width - boxWidth, lineX - boxWidth / 2))

                            Rectangle()
                                .fill(.quaternary)
                                .frame(width: 2, height: lineHeight)
                                .position(x: lineX, y: lineHeight / 2)

                            VStack(alignment: .leading) {
                                Text("Password: \(selectedElement.password)")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                Text("Strength: \(selectedElement.strength, format: .number)")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                            }
                            .frame(width: boxWidth, alignment: .leading)
                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.background)
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.quaternary.opacity(0.7))
                                }
                                .padding([.leading, .trailing], -8)
                                .padding([.top, .bottom], -4)
                            }
                            .offset(x: boxOffset)
                        }
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("As you type, your password's strength changes. This chart shows how much the stength has changed with each modification.")
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                
                Text("Please note: this is only an estimation. The model's strength prediction may be inaccurate.")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct PassChartView_Previews: PreviewProvider {
    static var previews: some View {
        PassChartView(data: .constant([.init(change: 1, strength: 10, password: "pass"),.init(change: 2, strength: 22, password: "password"), .init(change: 3, strength: 34, password: "p455w-0OR-d"), .init(change: 4, strength: 41, password: "password"), .init(change: 5, strength: 45, password: "P@@@A4555ss.word"), .init(change: 6, strength: 62, password: "p455w-0OR-d"), .init(change: 7, strength: 38, password: "p455w-0OR-d"), .init(change: 8, strength: 72, password: "p455w-0OR-d"), .init(change: 9, strength: 91, password: "p4@5-w0000r-Dd$"), .init(change: 10, strength: 98, password: "p4@5-w0000r-Dd$")]))
    }
}
