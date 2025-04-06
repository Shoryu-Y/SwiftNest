import UIKit

class DraggableCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "DraggableCollectionViewCell"
    
    weak var label: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.label?.text = ""
        self.label = nil
    }

    func setup(text: String) {
        let label = UILabel()
        label.text = text

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            label.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            label.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
        contentView.backgroundColor = .lightGray

        self.label = label
    }
}
