//
//  ArticleProgressView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 10.04.2023.
//

import SwiftUI

/// View (article page) that displays the progress of a task
struct ArticleProgressView: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var article: Article
    
    var body: some View {
        VStack {
            ProgressCircleView(article: $article)
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(30)

            Text(article.button.description)
                .font(.title.monospaced())
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ArticleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleProgressView(article: .constant(ArticleStore().articles[1]))
    }
}
