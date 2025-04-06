import UIKit

final class IntervalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Present Target"

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                let viewController = TargetViewController()
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve
                self?.present(viewController, animated: true)
            },
            for: .touchUpInside
        )

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
