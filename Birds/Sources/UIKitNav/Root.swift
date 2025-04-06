import ComposableArchitecture
import SwiftUI
import UIKit

@Reducer
struct Root: Reducer {
    @Reducer(state: .equatable)
    enum Destination {
        case target(Target)
    }

    enum Presentation {
        case target
    }

    @ObservableState
    struct State: Equatable {
        @Presents var dest: Destination.State?
        var presentation: Presentation?
    }

    enum Action {
        case navigationButtonTapped

        case dest(PresentationAction<Destination.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigationButtonTapped:
//                state.dest = .target(Target.State())
                state.presentation = .target
                return .none

            case .dest:
                return .none
            }
        }
        .ifLet(\.$dest, action: \.dest)
    }
}

final class RootViewController: UIViewController {
    @UIBindable var store: StoreOf<Root>

    init() {
        self.store = Store(initialState: Root.State()) {
            Root()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Present Target"

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                self?.store.send(.navigationButtonTapped)
            },
            for: .touchUpInside
        )

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        //swift-navigationのエコシステムに乗っかった形
        present(item: $store.scope(state: \.dest?.target, action: \.dest.target)) { store in
            let viewController = TargetViewController()
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            return viewController
        }

        // swift-navigationに乗っからず、scopeでChildStoreを取り出してマニュアルに画面遷移
        // 画面遷移の状態とStateが直接結びつかないのでやらない方が良い
        observe { [weak self] in
            guard let self else {
                return
            }

            if let target = store.scope(state: \.dest?.target, action: \.dest.target) {
                let viewController = TargetViewController(store: target)
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve

                present(viewController, animated: true)
            }
        }

        // swift-navigationに乗っからず、マニュアルに画面遷移part 2
        // 画面遷移の状態とStateが直接結びつかないのでやらない方が良い
        observe { [weak self] in
            guard let self, let presentation = store.presentation else {
                return
            }

            switch presentation {
            case .target:
//                let viewController = TargetViewController()
//                viewController.modalPresentationStyle = .overFullScreen
//                viewController.modalTransitionStyle = .crossDissolve
//                present(viewController, animated: true)

                navigationController?.pushViewController(IntervalViewController(), animated: true)
            }
        }
    }
}

public struct RootView: UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> some UIViewController {
        UINavigationController(
            rootViewController: RootViewController()
        )
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
