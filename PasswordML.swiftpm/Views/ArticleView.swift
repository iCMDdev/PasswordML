//
//  ArticleView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 07.04.2023.
//

import SwiftUI


// View for an article (task)
struct ArticleView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var settings: Settings
    @ObservedObject var articleStore: ArticleStore
    @Binding var article: Article
    
    @State private var page: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $page) {
                ForEach($article.pages.sorted(by: { $0.wrappedValue.position < $1.wrappedValue.position}), id: \.wrappedValue.position) { $articlePage in
                    HStack {
                        if (articlePage as? InfoPage) != nil {
                            
                            // Force-casting binding, since wrapped value can be casted to InfoPage
                            let infoPageBinding: Binding<InfoPage> = Binding {
                                $articlePage.wrappedValue as! InfoPage
                            } set: { value in
                                $articlePage.wrappedValue = value
                            }

                            InfoPageView(page: infoPageBinding)
                            
                        }
                        
                        if  (articlePage as? QuizPage) != nil {
                            
                            // Force-casting binding, since wrapped value can be casted to QuizPage
                            let quizPageBinding: Binding<QuizPage> = Binding {
                                $articlePage.wrappedValue as! QuizPage
                            } set: { value in
                                $articlePage.wrappedValue = value
                            }

                            QuizPageView(articleStore: articleStore, page: quizPageBinding)
                                .environmentObject(settings)
                            
                        }
                    }
                    .tag(articlePage.position)
                    
                }
                ArticleProgressView(article: $article)
                    .tag(article.pages.count)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack {
                Button {
                    if page>0 {
                        withAnimation(.easeInOut) {
                            page -= 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(page>0 ? .accentColor : .clear)
                        .imageScale(.large)
                }
                Spacer()
                Text("PAGE \(page+1)/\(article.pages.count+1)")
                    .foregroundColor(colorScheme == .light ? Color(red: 0.30, green: 0.30, blue: 0.30) : .gray)
                    .font(.body.bold().monospaced())
                Spacer()
                Button {
                    if page<article.pages.count {
                        withAnimation(.easeInOut) {
                            page += 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(page<article.pages.count ? .accentColor : .clear)
                        .imageScale(.large)
                }
            }
            .padding(20)
            #if targetEnvironment(macCatalyst)
            .frame(maxWidth: 200)
            #endif
            
        
        }
        .background(colorScheme == .light ? Color.light : Color.dark)
    }
    
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(articleStore: ArticleStore(), article: .constant(ArticleStore().articles[0]))
    }
}
