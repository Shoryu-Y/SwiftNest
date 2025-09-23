//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/04/25.
//  Copyright © 2025 pixiv Inc. All rights reserved.
//

import SwiftUI
import UIKit

public struct RootViewRepresentable: UIViewControllerRepresentable {
    let viewController: UIViewController

    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: viewController)
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
