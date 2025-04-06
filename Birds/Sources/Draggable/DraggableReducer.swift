import ComposableArchitecture

@Reducer
struct DraggableReducer {
    @ObservableState
    struct State: Equatable {
        var items: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        var validation: Bool = true

        mutating func update(source: Int, destination: Int) {
            let item = items[source]
            items.remove(at: source)
            items.insert(item, at: destination)
        }
    }

    enum Action {
        case itemDragged(source: Int, destination: Int)
        case itemTapped
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .itemDragged(source, destination):
                state.update(source: source, destination: destination)
                return .none
            case .itemTapped:
                state.validation.toggle()
                return .none
            }
        }
    }
}
