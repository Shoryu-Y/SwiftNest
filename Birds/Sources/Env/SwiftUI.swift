//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/07/29.
//  Copyright © 2025 pixiv Inc. All rights reserved.
//

import SwiftUI

enum Destination {
    case next
}

public struct EnvRootView: View {
    @State var isOn: Bool = false
    @State var path: [Destination] = []

    public init() {}

    public var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Toggle(isOn: $isOn) {
                    Text("Toggle Theme Color")
                }

                Button {
                    path.append(.next)
                } label: {
                    Text("Next")
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .next:
                    NextView()
                        .environment(\.theme, Theme(color: isOn ? .red : .blue))
                }
            }
        }
    }
}

struct NextView: View {
    @Environment(\.theme) var theme
    @State var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Text("Show Modal")
        }
        .background(theme.color)
        .sheet(isPresented: $isPresented) {
            SheetView()
        }
    }
}

struct SheetView: View {
    @Environment(\.theme) var theme
    var body: some View {
        Text("Hello, World!")
            .background(theme.color)
    }
}
