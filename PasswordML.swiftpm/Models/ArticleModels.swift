//
//  Tutorial.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 07.04.2023.
//

import Foundation
import SwiftUI

/// The image used in an article's ``InfoPage``
enum ArticleImage: Codable {
    case none, password, stack, chart, key, people
}

/// Protocol that defines a page inside an article (also named task).
///
/// This protocol defines information required by an article page (whether it is an informative one or a quiz).
protocol ArticlePage: Equatable, Identifiable {
    var id: UUID { get }
    var title: String { get set }
    var description: String { get }
    var position: Int { get }
}

/// Answer options for an article's quiz
struct QuizAnswers: Hashable, Codable {
    let answers: [String]
    let correctAnswer: String
    var completed: Bool = false
}

/// Information about an article's button (`NavigationLink`) look on the apps' main menu.
struct ArticleButton: Equatable, Codable {
    
    /// The button's SF Symbol
    let symbol: String
    /// The button's text
    let description: String
}

/// Information about a specific article
///
/// Articles contain quizes (``QuizPage``) and informative pages (``InfoPage``) about a specific topic. This class stores information about those quizes and informative pages, as well as information about the button's (`NavigationLink`) look on the apps' main menu via `button`.
class Article: Identifiable, ObservableObject, Codable {
    
    // Conforming to Codable
    
    enum CodingKeys: CodingKey {
        case button, infoPages, quizPages
    }
    
    /// Init that decodes a value into an Article
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let infoPages: [InfoPage] = try values.decode(Array.self, forKey: .infoPages)
        let quizPages: [QuizPage] = try values.decode(Array.self, forKey: .quizPages)
        button = try values.decode(ArticleButton.self, forKey: .button)
        pages = quizPages + infoPages
    }
    
    /// Encodes an Article
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(filterInfoPages(), forKey: .infoPages)
        try container.encode(filterQuizPages(), forKey: .quizPages)
        try container.encode(button, forKey: .button)
    }
    
    /// Filters the info pages stored in ``pages``
    func filterInfoPages() -> [InfoPage] {
        var infoPages: [InfoPage] = []
        for page in pages {
            if let infoPage = page as? InfoPage {
                infoPages.append(infoPage)
            }
        }
        return infoPages
    }
    
    /// Filters the quiz pages stored in ``pages``/
    func filterQuizPages() -> [QuizPage] {
        var quizPages: [QuizPage] = []
        for page in pages {
            if let quizPage = page as? QuizPage {
                quizPages.append(quizPage)
            }
        }
        return quizPages
    }
    
    // Identifiable
    let id = UUID()
    
    /// An article's button (NavigationLink) on the app's main menu
    let button: ArticleButton
    @Published var pages: [any ArticlePage]
    
    /// Function used to check if an article's quizes were completed
    func completed() -> (quizes: Int, completed: Int) {
        var quizes: Int = 0
        var completedQuizes: Int = 0
        
        for page in pages {
            if let quiz = page as? QuizPage {
                quizes += 1
                if quiz.question.completed {
                    completedQuizes += 1
                }
            }
        }
        return (quizes: quizes, completed: completedQuizes)
    }
    
    init(buttonSymbol: String, colors: [Color], buttonDescription: String, pages: [any ArticlePage]) {
        self.button = ArticleButton(symbol: buttonSymbol, /*colors: colors,*/ description: buttonDescription)
        self.pages = pages
    }
}


/// An informative page inside an ``Article``. Conforms to ``ArticlePage``
struct InfoPage: ArticlePage, Identifiable, Hashable, Codable {
    var id = UUID()
    let position: Int
    var title: String
    let description: String
    let image: ArticleImage
}

/// A quiz page inside an ``Article``. Conforms to ``ArticlePage``
struct QuizPage: ArticlePage, Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    let description: String
    let position: Int
    
    var question: QuizAnswers
}
