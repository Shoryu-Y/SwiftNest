import SwiftUI
import UIKit

public struct PencilInteractionView: UIViewRepresentable {
    private let pencilInteractionViewController = PencilInteractionViewController()

    public init() {}

    public func updateUIView(_ uiView: UIView, context: Context) {}

    public func makeUIView(context: Context) -> UIView {
        return pencilInteractionViewController.view
    }
}

private class PencilInteractionViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        setPencilInteraction()
        addSwiftUISubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is unimplemented")
    }

    private func addSwiftUISubView() {
        let uiHostingController = UIHostingController(rootView: ContentView())
        uiHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        uiHostingController.view.frame = view.bounds
        addChild(uiHostingController)
        view.addSubview(uiHostingController.view)
        uiHostingController.didMove(toParent: self)
    }
}

extension PencilInteractionViewController: UIPencilInteractionDelegate {
    private func setPencilInteraction() {
        let pencilInteraction = UIPencilInteraction()
        pencilInteraction.delegate = self
        view.addInteraction(pencilInteraction)
    }

    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        print("hoge")
    }
}

extension PencilInteractionViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            switch touch.type {
            case .pencil:
                print("Pencil!!!")
            default:
                print("Defualt")
            }
        }
    }
}

private struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
