import SwiftUI

public struct DraggableView: View {
    private var padding: CGFloat { 8.0 }
    private var space: CGFloat { 8.0 }
    private var cellSize: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        // 画面の横幅から両端のpaddinとcell間のspaceを引き、cellの個数(3)で割る
        let cellWidth = (screenWidth - padding * 2 - space * 4) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }

    public init() {}

    public var body: some View {
        Grid(horizontalSpacing: space, verticalSpacing: space) {
            GridRow {
                ForEach(0..<3) { index in
                    ZStack {
                        Color.gray
                        Text("\(index)")
                    }
                }
                .frame(width: cellSize.width, height: cellSize.width)
            }
        }
        .onDrag {
            NSItemProvider(object: "\(index)" as NSString)
        }
        .onDrop(of: ["public.utf8-plain-text"], delegate: D())
    }
}

class D: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        true
    }

    func dropEntered(info: DropInfo) {
        print(info)
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return .init(operation: .move)
    }

}
