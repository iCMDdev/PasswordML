//
//  SettingsView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 08.04.2023.
//

import SwiftUI

/// View that displays this app's settings
struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var articles: ArticleStore
    @Binding var wasFirstArticleCompleted: Bool
    
    @State private var showAcknowledgment = false
    @State private var showLegal = false
    @State private var resetProgressAlert: Bool = false
    
    /// `String` that stores this app's acknowledgments
    ///
    /// This searches for the ACKNOWLEDGMENTS.txt resource.
    private var acknowledgements: String {
        guard let url = Bundle.main.url(forResource: "ACKNOWLEDGMENTS", withExtension: "txt") else {
            return "Sorry, the acknowledgments file was not found."
        }
        
        do {
            return try String(contentsOf: url)
        } catch {
            print(error.localizedDescription)
            return "Sorry, something went wrong with the acknowledgments file."
        }
    }
    
    /// `String` that stores this app's legal notice.
    ///
    /// This searches for the LEGALNOTICE.txt resource.
    private var legal: String {
        guard let url = Bundle.main.url(forResource: "LEGALNOTICE", withExtension: "txt") else {
            return "Sorry, the legal notice file was not found."
        }
        
        do {
            return try String(contentsOf: url)
        } catch {
            print(error.localizedDescription)
            return "Sorry, something went wrong with the legal notice file."
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                HStack {
                    LogoView(size: 100, radius: 30, fontSize: 70, animated: false)
                    VStack {
                        Text("PasswordML")
                            .font(.title.bold())
                        Text("Developed by CMD")
                            .font(.body.monospaced())
                        Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String != nil ? "v"+(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) : "")
                    }
                    .padding(.leading)
                }
                .padding(.vertical)
                .padding(.vertical)
                
                VStack {
                    
                    Toggle(isOn: $settings.soundEffectsSetting) {
                        Text("Sound Effects")
                    } .padding(.bottom)
                    
                    HStack {
                        Text("ML model")
                        Spacer()
                        Text(settings.modelVersion)
                            .font(.body.monospaced())
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding()
                .padding(.vertical)
                VStack(alignment: .leading) {
                    Text("Important information")
                        .bold()
                        .padding(.bottom)
                    HStack {
                        Spacer()
                    }
                    Text("The password strength ML model provides only an estimation. The model's strength prediction may be inaccurate. Some example cases include passwords composed out of a repeating special character.\n\nPasswordML never stores your passwords permanently. They may be stored temporarily to show the Password Strength Variation Chart until you clear them, or close the password checker view.")
                        
                }
                .padding()
                Button(showLegal ? "Hide Legal Notice" : "Show Legal Notice") {
                    withAnimation(.easeInOut) {
                        showLegal.toggle()
                    }
                }
                .padding(.vertical)
                if showLegal {
                    HStack {
                        Text("Legal Notice")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    Text(legal)
                        .padding()
                }
                Button(showAcknowledgment ? "Hide acknowledgments" : "Show acknowledgments") {
                    withAnimation(.easeInOut) {
                        showAcknowledgment.toggle()
                    }
                }
                .padding(.vertical)
                if showAcknowledgment {
                    HStack {
                        Text("Acknowledgments")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    Text(acknowledgements)
                        .padding()
                }
                HStack {
                    Button(role: .destructive) {
                        resetProgressAlert = true
                    } label: {
                        Text("Reset progress")
                    }
                    .confirmationDialog("Are you sure?", isPresented: $resetProgressAlert) {
                        Button(role: .destructive) {
                            articles.resetProgress()
                            wasFirstArticleCompleted = false
                        } label: {
                            Text("Delete progress")
                        }
                    } message: {
                        Text("Are you sure? This action cannot be undone.")
                    }
                    
                }
                .padding()
                Spacer()
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(wasFirstArticleCompleted: .constant(false))
            .environmentObject(Settings())
    }
}
