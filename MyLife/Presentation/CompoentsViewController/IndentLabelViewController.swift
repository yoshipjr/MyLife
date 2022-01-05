import UIKit

final class IndentLabelViewController: UIViewController {

    struct Dummy {
        static let text = "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
    }

    private let indentLabel: UILabel = {
        let label = IndentLabel(insets: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        label.numberOfLines = 0
        label.text = Dummy.text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = ColorResource.Base.lightBlue
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(indentLabel)

        NSLayoutConstraint.activate([
            indentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            indentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            indentLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
