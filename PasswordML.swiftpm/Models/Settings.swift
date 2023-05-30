//
//  SettingsClass.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 08.04.2023.
//

import SwiftUI

/// User's Color Scheme choice (match system, dark or light)
enum ColorSchemeSetting: Int {
    case system, dark, light
}

/// Class that manages the app's settings (user preferences) and saves it to UserDefaults
///
/// This class stores the colorScheme user preference. When the ``colorSchemeSetting`` attribute is set, it is also saved to UserDefaults, in order for it to be persistent between app launches. It is automatically initialized with the value saved in UserDefaults.
class Settings: ObservableObject {
    /// Actual Color Scheme saved value. It is used internally by the class and returned via ``colorSchemeSetting`` when accessed.
    @Published private var colorScheme: ColorSchemeSetting = /*ColorSchemeSetting(rawValue: UserDefaults.standard.integer(forKey: "colorSchemeSetting")) ??*/ .system
    
    /// Indicates whether sound effects are turned on or off. It is used internally by the class and returned via ``colorSchemeSetting`` when accessed.
    @Published private var soundEffects: Bool = !(UserDefaults.standard.bool(forKey: "soundEffectsSetting"))
    
    /// Indicates whether sound effects are turned on or off. When set, saves value to UserSettings.
    var soundEffectsSetting: Bool {
        get {
            return self.soundEffects
        }
        set (newSetting) {
            UserDefaults.standard.set(!newSetting, forKey: "soundEffectsSetting")
            self.soundEffects = newSetting
        }
    }
    
    /// Color Scheme User Preference, which, when set, saves value to UserSettings. This setting is set to "system" in a normal user app. It was only used for testing.
    var colorSchemeSetting: ColorSchemeSetting {
        get {
            return self.colorScheme
        }
        set (newScheme) {
            UserDefaults.standard.set(newScheme.rawValue, forKey: "colorSchemeSetting")
            self.colorScheme = newScheme
        }
    }
    
    /*init() {
        colorSchemeSetting = ColorSchemeSetting(rawValue: UserDefaults.standard.integer(forKey: "colorSchemeSetting")) ?? .system
    }*/
    /// Stores the ML model version
    let modelVersion: String = "PasswordML v2.0"
}
