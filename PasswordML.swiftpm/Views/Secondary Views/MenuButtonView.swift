//
//  MenuButtonView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 08.04.2023.
//

import SwiftUI

/// A struct used as a `NavigationLink` label  for the tasks (articles)
struct MenuButtonView: View {
    @Binding var article: Article
    let gradient = Gradient(colors: [.cyan, .blue, .purple, .orange, .pink, .red])
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: article.button.symbol)
                    .font(.system(size: 30))
                    .foregroundStyle(.linearGradient(Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))

                    .opacity(0.7)
                Spacer()
            }
            .frame(width: 40)
            Text(article.button.description)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .bold()
            Spacer()
            Text("\(article.completed().completed)/\(article.completed().quizes)")
                .foregroundColor(.gray)
                .font(.title2)
            Image(systemName: "chevron.right")
        }
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(article: .constant(ArticleStore().articles[0]))
    }
}
