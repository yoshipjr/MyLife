import UIKit

final class SampleFooter: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let label = IndentLabel(insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        label.backgroundColor = ColorResource.Base.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SampleFooter"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubviews(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
