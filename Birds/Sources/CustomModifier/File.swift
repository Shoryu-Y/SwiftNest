//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/04/06.
//

import SwiftUI

public struct RootView: View {
    enum Destination: String, Hashable {
        case first
        case second
        case third
    }

    public init() {}

    @State var destination: [Destination] = []

    public var body: some View {
        NavigationStack(path: $destination) {
            VStack {
                CustomizingImageView(systemName: "hand.thumbsup.fill")

                Button {
                    destination.append(.first)
                } label: {
                    Text("Navigation")
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                DestinationView(destination: destination)
            }
        }
        .applyCustomizingImage()
    }
}

struct DestinationView: View {
    let destination: RootView.Destination

    var body: some View {
        VStack {
            CustomizingImageView(systemName: "hand.thumbsup.fill")

            Text("Destination: \(destination.rawValue)")
        }
    }
}

public struct ContentView: View {
    public init() {}

    public var body: some View {
        HStack {
            CustomizingImageView(systemName: "hand.thumbsup.fill")

            CustomizingImageView(systemName: "pencil.circle.fill")

            CustomizingImageView(systemName: "person.crop.circle.fill")
        }
        .applyCustomizingImage()
    }
}

struct CustomizingImageView: View {
    @Environment(\.customizingImage) private var customizingImage

    let systemName: String

    var body: some View {
        customizingImage(Image(systemName: systemName))
    }
}

extension View {
    func applyCustomizingImage() -> some View {
        self
            .environment(\.customizingImage) { image in
                let imageCustomized = image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.blue)

                return AnyView(imageCustomized)
            }
    }
}

extension EnvironmentValues {
    @Entry var customizingImage: (_ image: Image) -> AnyView = { AnyView($0) }
}

#Preview {
    ContentView()
}

struct CustomImageThemeModifier: ViewModifier {
    @Environment(\.isEnabled) var isa
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundStyle(.blue)
    }
}
