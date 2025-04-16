//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/04/15.
//

import SwiftUI
import UIKit

public struct RootView: View {
    public init() {}
    public var body: some View {
        RootViewControllerRepresenting()
            .environment(\.theme, Theme(color: .green))
    }
}

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = .systemBackground

        let child = UIHostingController(
            rootView: ChildView(title: "RootViewController")
                .environment(\.theme, Theme(color: .red))
        )
        child.view.translatesAutoresizingMaskIntoConstraints = false

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Next"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                self?.navigationController?.pushViewController(DestinatedViewController(), animated: true)
            },
            for: .touchUpInside
        )

        view.addSubview(child.view)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
        ])
    }
}

public struct RootViewControllerRepresenting: UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> some UIViewController {
        UINavigationController(
            rootViewController: RootViewController()
        )
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ChildView: View {
    @Environment(\.theme) var theme

    let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .foregroundStyle(theme.color)
    }
}

final class DestinatedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let child = UIHostingController(
            rootView: ChildView(title: "DestinatedViewController")
        )
        child.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
