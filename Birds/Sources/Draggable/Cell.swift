import UIKit

public final class StreetCellContentView: UIView {
    public init() {
        super.init(frame: .zero)
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    func setup() {
        let width = UIScreen.main.bounds.width
        let content = UIView()
        content.backgroundColor = .blue
        content.frame = .init(origin: .init(), size: .init(width: width, height: width))

        let stackView = UIStackView()
        stackView.frame = .init(origin: .init(), size: .init(width: width, height: width))
        stackView.addArrangedSubview(content)



        self.addSubview(stackView)

//        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: stackView.topAnchor),
            content.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
}

#Preview(traits: .defaultLayout) {
    let view = StreetCellContentView()
    view.setup()

    return view
}
