//
//  InfoPageView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 07.04.2023.
//

import SwiftUI

/// View used in a task (article) that has information on a specific topic
struct InfoPageView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @Binding var page: InfoPage
    @State private var value: Double = 0

    let brainGradient = Gradient(colors: [.cyan, .blue, .purple, .pink])
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                switch page.image {
                case .password:
                    HStack {
                        ForEach(0..<4) { _ in
                            Image(systemName: "circle.fill")
                                .font(.system(size: 30).bold().monospaced())
                                .foregroundColor(.gray)
                        }
                    }
                case .stack:
                    ZStack {
                        Image(systemName: "square.stack.3d.up.fill", variableValue: value)
                            .foregroundStyle(value == 0 ? Gradient(colors: [.gray]) : brainGradient)
                            .imageScale(.large)
                            .font(.system(size: 60))
                            .onReceive(timer) { _ in
                                if value < 1.0 {
                                    withAnimation(.easeInOut) {
                                        value += 0.25
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        value = 0
                                    }
                                }
                            }
                        Image(systemName: "square.stack.3d.up.fill", variableValue: value)
                            .foregroundStyle(value == 0 ? Gradient(colors: [.gray]) : brainGradient)
                            .imageScale(.large)
                            .font(.system(size: 60))
                            .blur(radius: 30).opacity(0.75)
                    }
                case .chart:
                    ZStack {
                        Image(systemName: "chart.bar.xaxis", variableValue: value)
                            .foregroundStyle(Gradient(colors: [.yellow, .pink, .indigo]))
                            .imageScale(.large)
                            .font(.system(size: 60))
                            .onReceive(timer) { _ in
                                if value < 1.0 {
                                    withAnimation(.easeInOut) {
                                        value += 0.25
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        value = 0
                                    }
                                }
                            }
                        Image(systemName: "chart.bar.xaxis", variableValue: value)
                            .foregroundStyle(value == 0 ? Gradient(colors: [.gray]) : Gradient(colors: [.yellow, .pink, .indigo]))
                            .imageScale(.large)
                            .font(.system(size: 60))
                            .blur(radius: 30).opacity(0.75)
                    }
                case .key:
                    Image(systemName: "key.horizontal")
                        .font(.system(size: 60).bold().monospaced())
                        .foregroundColor(.gray)
                case .people:
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 60).bold().monospaced())
                        .foregroundColor(.gray)
                case .none:
                    Rectangle()
                }
                /*
                 
                 }*/
            }
            .padding()
            .background(colorScheme == .light ? Color.light : Color.dark)
            .cornerRadius(30)
            .shadow(color: (colorScheme == .light ? Color.black.opacity(0.2) : Color.black.opacity(0.7)), radius: 10, x:10, y: 10)
            .shadow(color: (colorScheme == .light ? Color.white.opacity(0.7) : Color.white.opacity(0.075)), radius: 10, x:-5, y: -5)
            
            Text(page.title)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Text(page.description)
                .frame(maxWidth: 500)
                .padding(.vertical)
        }
        .padding()
    }
}

struct TutorialPageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPageView(page: .constant(ArticleStore().articles[0].pages[0] as! InfoPage))
    }
}
