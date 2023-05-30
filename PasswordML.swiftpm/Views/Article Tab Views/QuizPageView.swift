//
//  QuizPageView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 09.04.2023.
//

import SwiftUI
import AVFoundation

/// View used in a task (article) that has a quiz
struct QuizPageView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var settings: Settings
    @ObservedObject var articleStore: ArticleStore
    @Binding var page: QuizPage
    @State var questionsPicked: [String: Bool] = [:]
    
    @State private var correctPlayer: AVPlayer = AVPlayer.correctChoicePlayer
    @State private var wrongPlayer: AVPlayer = AVPlayer.wrongChoicePlayer
    
    var body: some View {
        VStack {
            Text(page.question.completed ? "COMPLETED" : "NOT COMPLETED")
                .font(.headline)
                .foregroundColor(colorScheme == .light ? Color(red: 0.30, green: 0.30, blue: 0.30) : .gray) // in order to pass contrast requirements
            HStack {
                /*ForEach(0..<4) { _ in
                    Image(systemName: "circle.fill")
                        .font(.system(size: 30).bold().monospaced())
                        .foregroundColor(.gray)
                       
                }*/
                if page.question.completed {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                }
                Text(page.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(colorScheme == .light ? Color.light : Color.dark)
            .cornerRadius(30)
            .shadow(color: (colorScheme == .light ? Color.black.opacity(0.2) : Color.black.opacity(0.7)), radius: 10, x:10, y: 10)
            .shadow(color: (colorScheme == .light ? Color.white.opacity(0.7) : Color.white.opacity(0.075)), radius: 10, x:-5, y: -5)
            
            
            Text(page.description)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 500)
                .padding(.vertical)
                .padding(.vertical)
                .font(.body.monospaced())
            
            VStack(alignment: .leading) {
                Text("Select one of the answers below.")
                    .font(.headline)
                    .foregroundColor(colorScheme == .light ? Color(red: 0.30, green: 0.30, blue: 0.30) : .gray)
                ForEach(page.question.answers, id: \.self) { answer in
                    Button {
                        withAnimation(.easeInOut) {
                            questionsPicked[answer] = true
                            if page.question.correctAnswer == answer {
                                if !page.question.completed && settings.soundEffectsSetting {
                                    correctPlayer.seek(to: .zero)
                                    correctPlayer.play()
                                }
                                page.question.completed = true
                            } else if !page.question.completed && settings.soundEffectsSetting {
                                wrongPlayer.seek(to: .zero)
                                wrongPlayer.play()
                            }
                        }
                    } label: {
                            ZStack {
                                if questionsPicked[answer] == true || (page.question.completed && page.question.correctAnswer == answer) {
                                    HStack {
                                        Image(systemName: (page.question.correctAnswer == answer ? "checkmark.seal.fill": "x.circle.fill"))
                                            .imageScale(.large)
                                        .foregroundColor(page.question.correctAnswer == answer ? .green : .red)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    
                                    HStack {
                                        Spacer()
                                        Text(answer)
                                        Spacer()
                                    }
                                    if questionsPicked[answer] == true && page.question.correctAnswer != answer {
                                        Text("Not quite... Try again!")
                                            .font(.footnote)
                                            .foregroundColor(colorScheme == .light ? Color(red: 0.30, green: 0.30, blue: 0.30) : Color(red: 0.75, green: 0.75, blue: 0.75)) // passes Color Contrast Calculator
                                    }
                                }
                                Spacer()
                            }
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: 500)
                }
                
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct QuizPageView_Previews: PreviewProvider {
    static var previews: some View {
        QuizPageView(articleStore: ArticleStore(), page: .constant(QuizPage(title: "Test quiz question", description: "Hello test!", position: 1, question: QuizAnswers(answers: ["Good", "Great"], correctAnswer: "Great"))))
            .environmentObject(Settings())
            .background(Color.light)
    }
}
