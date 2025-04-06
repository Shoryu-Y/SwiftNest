import ComposableArchitecture
import UIKit

public final class DraggableViewController: UIViewController {
    var collection: UICollectionView!
    let store: StoreOf<DraggableReducer>

    public init() {
        self.store = Store(
            initialState: DraggableReducer.State(),
            reducer: { DraggableReducer() }
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func loadView() {
        super.loadView()

        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )

        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        self.collection = collection
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        collection.register(DraggableCollectionViewCell.self, forCellWithReuseIdentifier: DraggableCollectionViewCell.identifier)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.dragDelegate = self
        collection.dropDelegate = self
        collection.dragInteractionEnabled = true

        observe { [weak self] in
            guard let self else { return }
            itemsChanged(self.store.items)
        }

        observe { [weak self] in
            guard let self else { return }
            validationChanged(self.store.validation)
        }
    }

    func itemsChanged(_ items: [Int]) {
        print("items: \(items)")
    }

    func validationChanged(_ validation: Bool) {
        print("validation: \(validation)")
    }

}

extension DraggableViewController: UICollectionViewDelegateFlowLayout {

    // MARK: UICollectionViewDelegateFlowLayout

    private var padding: CGFloat { 8.0 }
    private var space: CGFloat { 4.0 }
    private var cellSize: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        // 画面の横幅から両端のpaddinとcell間のspaceを引き、cellの個数(3)で割る
        let cellWidth = (screenWidth - padding * 2 - space * 4) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }

    // MARK: UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.store.send(.itemTapped)
    }
}

extension DraggableViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DraggableCollectionViewCell.identifier,
            for: indexPath
        )
        if let cell = cell as? DraggableCollectionViewCell {
            cell.setup(text: String(store.state.items[indexPath.row]))
        }

        return cell
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension DraggableViewController: UICollectionViewDragDelegate {
    public func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: String(indexPath.row) as NSString)
        return [.init(itemProvider: itemProvider)]
    }
}

extension DraggableViewController: UICollectionViewDropDelegate {
    public func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        switch coordinator.proposal.operation {
        case .move:
            guard
                let source = coordinator.items.first?.sourceIndexPath,
                let destination = coordinator.destinationIndexPath,
                let dragItem = coordinator.items.first?.dragItem else {
                return
            }
            collectionView.performBatchUpdates {
                store.send(.itemDragged(source: source.row, destination: destination.row))
                collectionView.moveItem(at: source, to: destination)
            }
            coordinator.drop(dragItem, toItemAt: destination)
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        .init(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
