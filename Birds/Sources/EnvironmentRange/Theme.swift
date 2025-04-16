//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/04/15.
//

import SwiftUI

public struct Theme {
    var color: Color

    public init(color: Color) {
        self.color = color
    }

    func updated(color: Color) -> Theme {
        var theme = self
        theme.color = color
        return theme
    }
}

public extension EnvironmentValues {
    @Entry var theme: Theme = Theme(color: .primary)
}
