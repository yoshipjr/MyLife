import UIKit

final class SampleCollectionViewCell: UICollectionViewCell {

    private var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.addSubview(textLabel)
    }

    private func setupConstraint() {
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configure(text: String) {
        textLabel.text = text
    }
}
