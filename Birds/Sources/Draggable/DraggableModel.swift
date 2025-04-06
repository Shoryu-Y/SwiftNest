
final class DraggableModel {
    var items: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]

    func update(from beginning: Int, to destination: Int) {
        print("from: \(beginning), to: \(destination)")
        let droppedItem = items[beginning]
        guard let firstIndex = items.firstIndex(of: droppedItem) else {
            return
        }
        items.remove(at: firstIndex)
        items.insert(droppedItem, at: destination)
        print(items)
    }
}
