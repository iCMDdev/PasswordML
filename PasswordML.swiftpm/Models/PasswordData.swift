//
//  PasswordData.swift
//  PasswordML
//
//  Created by Cristian-Mihai Dinca on 15.04.2023.
//

import Foundation

/// Defines a pasword's strength at a certain point in time
///
/// This is used by the password strength chart to store data. The
struct PasswordData: Identifiable {
    // Conforming to Identifiable
    let id = UUID()
    
    /// Stores which password change was recorded inside this struct.
    let change: Int
    
    /// Stores the password's estimated strength
    let strength: Int
    
    /// Stores the password as a String
    let password: String
}
