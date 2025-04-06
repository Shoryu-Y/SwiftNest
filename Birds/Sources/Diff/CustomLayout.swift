import SwiftUI
import UIKit

struct Stamp: Sendable, Hashable {
    let name: String
}

struct StampCollection<Content: View>: UIViewRepresentable {
    final class Coordinator: NSObject {
        var dataSource: DataSource!
    }

    @Binding var isOn: Bool
    @Binding var stamps: [Stamp]
    @ViewBuilder var content: (Stamp) -> Content

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 80
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let collectionView = UICollectionView(
            frame: .null,
            collectionViewLayout: layout
        )

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Stamp> { cell, indexPath, stamp in
            cell.contentConfiguration = UIHostingConfiguration {
                content(stamp)
            }
            .background(.blue)
        }

        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, stamp in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: stamp
            )
        }

        context.coordinator.dataSource = dataSource

        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(stamps)

        context.coordinator.dataSource.apply(snapshot)
        if let dataSource = uiView.dataSource as? DataSource {
            dataSource.apply(snapshot)
        }

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = isOn ? CGSize(width: 100, height: 100) : CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        uiView.setCollectionViewLayout(layout, animated: true)
    }
}

extension StampCollection {
    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Stamp>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Stamp>
}

struct MainView: View {
    @State var isOn: Bool = false
    @State var count: Int = 9
    @State var stamps: [Stamp] = [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3"),
        .init(name: "4"),
        .init(name: "5"),
        .init(name: "6"),
        .init(name: "7"),
        .init(name: "8"),
        .init(name: "9"),
//        .init(name: "10"),
//        .init(name: "11"),
//        .init(name: "12"),
//        .init(name: "13"),
//        .init(name: "14"),
//        .init(name: "15"),
//        .init(name: "16"),
//        .init(name: "17"),
//        .init(name: "18"),
//        .init(name: "19"),
//        .init(name: "20"),
//        .init(name: "21"),
//        .init(name: "22"),
//        .init(name: "23"),
//        .init(name: "24"),
//        .init(name: "25"),
//        .init(name: "26"),
//        .init(name: "27"),
//        .init(name: "28"),
//        .init(name: "29"),
    ]

    var body: some View {
        StampCollection(isOn: $isOn, stamps: $stamps) { stamp in
            Text("\(stamp.name)")
                .onAppear {
                    print("onAppear:", stamp.name)
                }
                .onDisappear {
                    print("onDisappear:", stamp.name)
                }
                .onTapGesture {
                    isOn.toggle()
                }
        }
        .task {
//            countUpLoop()
        }
    }

    private func countUpLoop() {
        Task.detached {
            try await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
                count += 1
                stamps.append(.init(name: "\(count)"))
                countUpLoop()
            }
        }
    }
}

#Preview {
    MainView()
}
