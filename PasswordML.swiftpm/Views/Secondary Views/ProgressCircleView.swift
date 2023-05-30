//
//  ProgressCircleView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 11.04.2023.
//

import SwiftUI

/// A circular gauge used to display the progress of a task (article)
struct ProgressCircleView: View {
    @Binding var article: Article
    @State private var finalAngle: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, lineWidth: 30)
            Circle()
                    .trim(from: 0.0, to: finalAngle)
                    .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: -90))
            VStack {
                Text("\(article.completed().completed)/\(article.completed().quizes)")
                    .font(.system(size: 80))
                Text("Progress")
                    .onAppear {
                        finalAngle = 0
                        withAnimation(.easeInOut(duration: 2)) {
                            let progress = article.completed()
                            finalAngle = Double(progress.completed)/Double(progress.quizes)
                        }
                    }
            }
        }
        .padding(40)
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(article: .constant(ArticleStore().articles[0]))
    }
}
