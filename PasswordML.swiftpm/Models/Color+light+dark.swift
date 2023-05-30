//
//  Color+light+dark.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 07.04.2023.
//

import SwiftUI

extension Color {
    /// Light color, used as a background, for creating a depth effect
    ///
    /// In combination with Views placed in front, that use shadows, a depth effect is created.
    static let light = Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255)
    
    /// Dark color, used as a background, for creating a depth effect
    ///
    /// In combination with Views placed in front, that use shadows, a depth effect is created.
    static let dark = Color(red: 40 / 255, green: 40 / 255, blue: 40 / 255)
}
