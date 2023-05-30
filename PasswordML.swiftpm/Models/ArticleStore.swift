//
//  ArticleStore.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 12.04.2023.
//

import Foundation
import SwiftUI

/// Class used to access, load and store all articles and quiz progress.
class ArticleStore: ObservableObject {
    
    /*  License details about fileURL(), load() and store()
        These functions were borrowed from Apple's Scrumdinger tutorial that can be found at https://developer.apple.com/tutorials/app-dev-training/getting-started-with-scrumdinger.
        
        The license can be found below, or in the LICENSE folder.
        
        License:
         Copyright © 2021 Apple Inc.

         Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

         The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

         THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
     
     */
    
    /// Finds the Article data file
    ///
    /// This function was borrowed from the Apple's Scrumdinger tutorial. MiT licensed.
    /// Modifications were made.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
            .appendingPathComponent("articles.data")
    }
    
    /// Loads the articles
    ///
    /// This function was borrowed from the Apple's Scrumdinger tutorial. MiT licensed.
    /// Modifications were made.
    static func load(completion: @escaping (Result<[Article], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([Article].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Stores the articles
    ///
    ///
    /// This function was borrowed from the Apple's Scrumdinger tutorial. MiT licensed.
    /// Modifications were made.
    static func save(articles: [Article], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(articles)
                let outfile = try fileURL()
                try data.write(to: outfile)
            } catch {
            }
        }
    }
    
    init() {
        self.articles = []
        resetProgress()
    }
    
    /// The app's articles
    @Published var articles: [Article]
    
    /// Checks if at least an article was completed.
    func anyArticleCompleted() -> Bool {
        for article in articles {
            let completedInfo = article.completed()
            if completedInfo.completed == completedInfo.quizes && completedInfo.quizes != 0 {
                return true
            }
        }
        return false
    }
    
    /// Resets the quiz progress
    func resetProgress() {
        articles = [
            Article(buttonSymbol: "doc.text", colors: [.pink, .red, .orange], buttonDescription: "Learn what makes a good password", pages: [InfoPage(position: 0, title: "Common passwords", description: "It's important to have an uncommon password. Common passwords can be easily guessed due to them being used frequently. Hackers have lists with the most common passwords, so if you have one, you're the most at risk.\n\nSome examples of common passwords are: \"password\", \"123456\", \"qwerty\". ", image: .people), QuizPage(title: "Choose the worst password", description: "What is the most common password out of the options?", position: 1, question: QuizAnswers(answers: ["password", "Password", "common", "fruit"], correctAnswer: "password")), InfoPage(position: 2, title: "Range of characters", description: "Having multiple character types (uppercase, lowercase, numbers, and special characters) makes your password hard to break, since it takes more time to be generated.\n\nWhen hackers fail to break a password using a list, they try generating them. When there are more character types, there are more options a computer has to generate.", image: .chart), QuizPage(title: "Choose the best", description: "Which is the best password?", position: 3, question: QuizAnswers(answers: ["p4ssw0rd", "nOhin-L0fy", "n0th1ng1", "Fruit84"], correctAnswer: "nOhin-L0fy")), InfoPage(position: 4, title: "Length", description: "For a similar reason, longer passwords are harder to generate. Mathematically, there are more options for a machine to choose from.", image: .password), QuizPage(title: "Choose the best", description: "Which is the best password?", position: 5, question: QuizAnswers(answers: ["pass-w0rd", "14S5-wO1D", "10nG-145S-word", "Fruit-pass-84"], correctAnswer: "10nG-145S-word")), InfoPage(position: 6, title: "Relevance to you", description: "When someone knows you, they might guess details such as your birthday, favourite pet, subject or singer. And even if they don't know you, they might be able obtain these datails through social engineering or from social media. This is why your password shouldn't contain any of this information.", image: .people)]),
            
            Article(buttonSymbol: "atom", colors: [.cyan, .blue, .indigo], buttonDescription: "The science behind passwords", pages: [InfoPage(position: 0, title: "When were passwords created?", description: "Passwords have been used since ancient times. They were used by sentries to only let specific people pass.\n\nMany of the modern cybersecurity principles have started since then. Another interesting example is ciphers - the Caesar cipher was used by Julius Caesar to encrypt messages.\n\nSource: Wikipedia.org", image: .people), QuizPage(title: "True or false?", description: "Passwords have been used since ancient times.", position: 1, question: QuizAnswers(answers: ["True", "False"], correctAnswer: "True")), InfoPage(position: 2, title: "How are passwords stored?", description: "Passwords should be hashed - so that if they are leaked, their descriptions wouldn't be exposed.\n\nHashing is an irreversible function that takes a password as input and gives a unique output.\n\nThis way, only a certain password can generate a specific hash, and if you have a hash, you cannot find out the original password unless you try hashing many posibilities.", image: .stack), QuizPage(title: "Cryptography question", description: "What is a hash?", position: 3, question: QuizAnswers(answers: ["A reversible function", "An irreversible function"], correctAnswer: "An irreversible function")), InfoPage(position: 4, title: "How are passwords broken?", description: "Passwords can be broken by using brute force attacks. In a brute force attack, a malicious actor tries many passwords, either by generating them, using a list of common passwords, or a combination of both.\n\nThis is usually done when an attacker has a password hash database, and wants to break them.", image: .password), QuizPage(title: "Break the hash!", description: "What is an attack that can be used to break hashed passwords?", position: 5, question: QuizAnswers(answers: ["Hash attack", "Brute-force attack", "Cross-site scripting", "Buffer overflow"], correctAnswer: "Brute-force attack"))]),
            
            Article(buttonSymbol: "questionmark.key.filled", colors: [.cyan, .blue, .indigo], buttonDescription: "Future of passwords", pages: [InfoPage(position: 0, title: "Password vulnerabilities", description: "Passwords are vulnerable, from social engineering, to people not setting good ones for their accounts. Even strong passwords aren't as strong as they used to be, since computational power is in a constant increase - that means it takes less time to break them.", image: .people), QuizPage(title: "Yes or no?", description: "From a computational point of view, are passwords as secure as they used to be?", position: 1, question: QuizAnswers(answers: ["Yes", "No"], correctAnswer: "No")), InfoPage(position: 2, title: "Replacing passwords", description: "The industry has already thought of this. The FIDO™️ Alliance (\"Fast IDentity Online\"), formed of important members of the tech industry, created the FIDO standard of passwordless sign‑ins. Passkeys are a new way to sign in to websites without a password.", image: .stack), QuizPage(title: "Going passwordless", description: "Which is a passwordless sign-in method?", position: 3, question: QuizAnswers(answers: ["Passterms", "Passkeys", "Passwords", "Passciphers"], correctAnswer: "Passkeys")), InfoPage(position: 4, title: "How are passkeys safe?", description: "Passkeys are always strong - they're random, hard to guess, and never used for multiple apps. They are safer against social engineering attacks, since they are linked to a specific website, and users can't be tricked to enter a passkey on another one. Also, servers don't store the passkeys - they store public keys, which cannot be used to obtain them.", image: .key), QuizPage(title: "Passkey safety", description: "Are passkeys safe to social engineering attacks?", position: 5, question: QuizAnswers(answers: ["Yes", "No"], correctAnswer: "Yes"))]),
        ]
    }
}
