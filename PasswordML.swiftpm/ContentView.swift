//
//  ContentView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.scenePhase) private var scenePhase
    
    @EnvironmentObject var settings: Settings
    @StateObject var articles: ArticleStore = ArticleStore()
    @State var passwordModel = PasswordModel()
    
    
    @AppStorage("firstLoad") private var firstLoad: Bool = true
    @State private var isShowingSheet = true
    @State private var isShowingSettings = false
    @State private var isShowingCongratsSheet = false
    @State private var wasFirstArticleCompleted: Bool = false

    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text(articles.anyArticleCompleted() ? "> Congratulations on completing a task! You're a password master." : "> Passwords protect lots of data.\n\n> Complete a task to become a password master.")
                                .font(.title3.monospaced())
                                .padding()
                            Spacer()
                        }
                        .padding()
                        .bold()
                        .background(.linearGradient(Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.bottom)
                        .padding(.top, 120)
                        Text("   TASKS")
                            .font(.footnote.bold())
                        ForEach($articles.articles) { article in
                            NavigationLink {
                                ArticleView(articleStore: articles, article: article)
                            } label: {
                                MenuButtonView(article: article)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                            .padding()
                            .background(colorScheme == .light ? Color.light : Color.dark)
                            .cornerRadius(20)
                        }
                    }
                }
                HStack {
                    LogoView(size: 50, radius: 15, fontSize: 30, animated: false, background: false)
                    Text("PasswordML")
                        .font(.headline.bold())
                    Spacer()
                    Button {
                        isShowingSheet = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .imageScale(.large)
                    }
                    .padding(.trailing)
                    .accessibilityLabel("Help button")
                    
                    NavigationLink {
                        SettingsView(wasFirstArticleCompleted: $wasFirstArticleCompleted)
                            .environmentObject(settings)
                            .environmentObject(articles)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                    }
                    .accessibilityLabel("Settings button")
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(20)
                .padding(.bottom)
                .padding(.top)
                
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        PasswordCheckerView(passwordModel: passwordModel)
                    } label: {
                        PasswordTestButtonView()
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
            .onReceive(articles.$articles) { output in
                if wasFirstArticleCompleted == false && articles.anyArticleCompleted() {
                    wasFirstArticleCompleted = true
                    isShowingCongratsSheet = true
                }
            }
            .toolbar(.hidden, for: .navigationBar)
                
        }  detail: {
            PasswordCheckerView(passwordModel: passwordModel)
        } 
        .onAppear {
            if !firstLoad {
                // if it is not the first load
                ArticleStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let articleList):
                        articles.articles = articleList
                        wasFirstArticleCompleted = articles.anyArticleCompleted()
                    }
                }
                if articles.articles.count == 0 {
                    print("Warning, no progress was stored, though it seems this isn't the first run.")
                    articles.resetProgress()
                    
                }
            } else {
                // on first load, do not load from memory, keep default values
                firstLoad = false
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive || phase == .background {
                ArticleStore.save(articles: articles.articles) { result in
                    if case .failure(let error) = result {
                       fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .onReceive(articles.$articles) { articleList in
            ArticleStore.save(articles: articleList) { result in
                if case .failure(let error) = result {
                   fatalError(error.localizedDescription)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet){
            InfoSheetView(isShowingSheet: $isShowingSheet)
                //.preferredColorScheme(settings.colorSchemeSetting == .system ? nil : (settings.colorSchemeSetting == .light ? ColorScheme.light : ColorScheme.dark))
        }
        .sheet(isPresented: $isShowingCongratsSheet) {
            VStack {
                Spacer()
                LogoView()
                Text("Congrats on completing an article! You are now a password master.")
                    .font(.title3.bold())
                    .padding(.top)
                
                //Spacer()
                Text("What's next?")
                    .font(.headline.monospaced())
                    .padding(.top)
                    .padding(.bottom, 5)
                HStack {
                    Spacer()
                }
                Text("You can explore other articles, or test passwords using the ML model, by clicking on the \"Test a Password\" button in the main menu.")
                    .padding(.bottom)
                
                Button("Continue") {
                    isShowingCongratsSheet.toggle()
                }
                .padding()
                Spacer()
            }
            .padding()
            .multilineTextAlignment(.center)
            .background(.ultraThickMaterial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
