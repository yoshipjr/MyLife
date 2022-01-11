import UIKit

final class SampleHeader: UICollectionReusableView {

    private let centerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = IndentLabel(insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        label.backgroundColor = ColorResource.Base.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SampleHeader"
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "SampleHearderSubtitle"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        self.addSubviews(centerLine, titleLabel)

        NSLayoutConstraint.activate([
            centerLine.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            centerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            centerLine.heightAnchor.constraint(equalToConstant: 1),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func update(hasSubTitle: Bool) {

        if hasSubTitle {
            self.addSubview(subTitleLabel)

            NSLayoutConstraint.activate([
                subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            subTitleLabel.isHidden = false
        } else {
            subTitleLabel.isHidden = true
        }
    }
}
