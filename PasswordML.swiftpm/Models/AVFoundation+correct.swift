//
//  AVFoundation+correct.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 13.04.2023.
//

import Foundation
import AVFoundation

extension AVPlayer {
    /// AVPlayer for the correct choice sound, played when a correct answer is picked in a quiz
    static let correctChoicePlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "correct", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    /// AVPlayer for the incorrect choice sound, played when a wrong answer is picked in a quiz
    static let wrongChoicePlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "wrong", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
