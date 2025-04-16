import SwiftUI
import Pencil
import Draggable
import UIKitNav
import CustomModifier
import EnvironmentRange

public struct Nest: View {
    public init() {}

    public var body: some View {
//        VStack {
//            DraggableView()
//        }

//        CustomModifier.ContentView()

        EnvironmentRange.RootView()
    }
}

//struct DraggableView: UIViewControllerRepresentable {
//
//    typealias UIViewControllerType = DraggableViewController
//
//    func makeUIViewController(context: Context) -> DraggableViewController {
//        DraggableViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: DraggableViewController, context: Context) {}
//}
