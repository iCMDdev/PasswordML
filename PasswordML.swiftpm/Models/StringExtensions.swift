//
//  StringExtensions.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 05.04.2023.
//  These extensions are used to easily calculate the occurence of different characters. The defined functions are used in supplying the Password ML model with data.
//

import Foundation

extension String {
    /// Function that counts the numbers inside the String
    func countNumbers() -> Int {
        var charCnt = 0
        for char in self {
            if char.isNumber {
                charCnt += 1
            }
        }

        return charCnt
    }
    
    /// Function that checks if a character is present inside the String
    func hasCharacter(character: Character) -> Bool {
        for char in self {
            if char == character {
                return true
            }
        }
        
        return false
    }
    
    /// Function that counts the non-alphanumeric characters inside a String
    func countSpecialCharacters() -> Int {
        var charCnt = 0
        
        for char in self {
            if !char.isLetter && !char.isNumber {
                charCnt += 1
            }
        }
        return charCnt
    }
    
    /// Function that counts the letters inside a String
    func countLetters() -> Int {
        var charCnt = 0
        
        for char in self {
            if char.isLetter {
                charCnt += 1
            }
        }

        return charCnt
    }
    
    /// Function that counts the capital letters inside a String
    func countCapitalLetters()  -> Int {
        var charCnt = 0
        
        for char in self {
            if char.isUppercase {
                charCnt += 1
            }
        }

        return charCnt
    }
}
