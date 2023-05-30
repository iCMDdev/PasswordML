//
//  PasswordsModel.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 10.04.2023.
//

import Foundation
import CoreML

/// Class that stores the PasswordML Model, and a function to estimate a password's security.
///
/// This class is used to load the model once (stored in ``model``) and hold it in memory. It is a good optimization, as the model only needs to be loaded once by the app, rather than every time a prediction is needed.
///
/// ``calculate(password:)`` is useed to calculate a password's length.
class PasswordModel {
    /// The used ML model, loaded from Resources
    let model: passwordsmodel_2 = {
        do {
            return try passwordsmodel_2(configuration: MLModelConfiguration())
        } catch {
            print(error.localizedDescription)
            fatalError("Cannot create PasswordML model object")
        }
    }()
   
    /// Esfimates a password's security, using the PasswordML machine learing model
    func calculate(password: String) -> Double {
        guard let passOutput = try? model.prediction(Password: password, Special_characters: Double(password.countSpecialCharacters()), Numbers: Double(password.countNumbers()), Letters: Double(password.countLetters()), Capital_Letters: Double(password.countCapitalLetters())) else {
            fatalError("Unexpected runtime error when trying PasswordML model prediction")
        }
        return passOutput.Est__Security
    }
}
