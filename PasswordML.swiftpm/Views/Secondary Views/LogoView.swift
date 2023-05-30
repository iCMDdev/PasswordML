//
//  LogoView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 06.04.2023.
//

import SwiftUI

/// View that displays the PasswordML logo.
///
/// By default, the logo is animated, and has a specific size, but these can be changed using the parameters.
struct LogoView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    let brainGradient = Gradient(colors: [.cyan, .blue, .purple, .pink, .orange, .pink, .red, .purple, .blue, .cyan])
    
    @State var size: CGFloat = 175
    @State var radius: CGFloat = 50
    @State var fontSize: CGFloat = 120
    @State var animated: Bool = true
    @State var background: Bool = true
    
    @State private var startBrainGradient = UnitPoint(x: 4, y: 0)
    @State private var endBrainGradient = UnitPoint(x: 0, y: 2)
    
    var body: some View {
        ZStack {
            HStack {
                Image("Logo")
                    .resizable()
                    .foregroundStyle(.linearGradient(brainGradient, startPoint: startBrainGradient, endPoint: endBrainGradient))
                    .frame(width: fontSize, height: fontSize)
                    .onAppear {
                            if animated {
                                withAnimation(.easeInOut(duration: 1).speed(0.15).repeatForever(autoreverses: true))
                                {
                                    startBrainGradient = UnitPoint(x: 0, y: -2)
                                    endBrainGradient = UnitPoint(x: 4, y: 0)
                                }
                            }
                    }
            }
            HStack {
                if background {
                    // Blur background - creates a "neon light" effect
                    HStack {
                        Image("Logo")
                            .resizable()
                            .foregroundStyle(.linearGradient(brainGradient, startPoint: startBrainGradient, endPoint: endBrainGradient))
                            .frame(width: fontSize, height: fontSize)
                            .blur(radius: 30).opacity(1)
                    }
                }
            }
            
        }
        .frame(width: size, height: size)
        .background(background ? (colorScheme == .light ? Color.light : Color.dark) : .clear)
        .cornerRadius(radius)
        .shadow(color: (background ? (colorScheme == .light ? Color.black.opacity(0.2) : Color.black.opacity(0.7)) : .clear), radius: 10, x:10, y: 10)
        .shadow(color: (background ? (colorScheme == .light ? Color.white.opacity(0.7) : Color.white.opacity(0.075)) : .clear), radius: 10, x:-5, y: -5)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
