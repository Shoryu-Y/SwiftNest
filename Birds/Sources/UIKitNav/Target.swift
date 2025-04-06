import ComposableArchitecture
import UIKit

@Reducer
struct Target: Reducer {
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }

    enum Action {
        case countUpButtonTapped
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .countUpButtonTapped:
                state.count += 1
            }

            return .none
        }
    }
}

final class TargetViewController: UIViewController {
    let store: StoreOf<Target>

    init(store: StoreOf<Target>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    convenience init() {
        let store = Store(initialState: Target.State()) {
            Target()
        }
        self.init(store: store)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Count up"

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                self?.store.send(.countUpButtonTapped)
            },
            for: .touchUpInside
        )

        view.addSubview(countLabel)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        observe { [weak self] in
            guard let self else {
                return
            }

            countLabel.text = "\(store.count)"
        }
    }
}
