//
//  Theme.swift
//  Birds
//
//  Created by tatsubee on 2025/07/29.
//  Copyright © 2025 pixiv Inc. All rights reserved.
//

import SwiftUI
import UIKit

// - MARK: SwiftUI
struct Theme {
    var color: Color
}

extension EnvironmentValues {
    @Entry var theme: Theme = .init(color: .white)
}

// - MARK: UIKit

struct UIKitTheme {
    var color: UIColor
}

struct ThemeTrait: UITraitDefinition {
    static let defaultValue: UIKitTheme = UIKitTheme(color: .white)
}

extension UITraitCollection {
    var theme: UIKitTheme { self[ThemeTrait.self] }
}

extension UIMutableTraits {
    var theme: UIKitTheme {
        get { self[ThemeTrait.self] }
        set { self[ThemeTrait.self] = newValue }
    }
}
