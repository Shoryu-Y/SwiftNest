//
//  File.swift
//  Birds
//
//  Created by tatsubee on 2025/07/29.
//  Copyright © 2025 pixiv Inc. All rights reserved.
//

import UIKit

public final class EnvRootViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let navigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Navigation", for: .normal)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        navigationButton.addAction(
            .init { [weak self] _ in
                guard let self else { return }
                navigationController?.pushViewController(NextViewController(), animated: true)
            },
            for: .touchUpInside
        )

        let button = UIButton()
        button.setTitle("Change Theme", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addAction(
            .init { [weak self] _ in
                guard let self else { return }
                navigationController?.traitOverrides.theme = .init(color: .red)
            },
            for: .touchUpInside
        )

        let stackView = UIStackView(arrangedSubviews: [button, navigationButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        registerForTraitChanges([ThemeTrait.self], action: #selector(hoge))
    }

    @objc private func hoge() {
        view.backgroundColor = traitCollection.theme.color
    }
}

final class NextViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForTraitChanges([ThemeTrait.self], action: #selector(hoge))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @objc private func hoge() {
        view.backgroundColor = traitCollection.theme.color
    }
}
