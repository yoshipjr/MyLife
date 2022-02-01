import UIKit

final class ComponentContainerViewController: UIViewController {
    private let backGroundColor: UIColor
    private let component: UIView
    private let componentWidth: CGFloat?
    private let componentHeight: CGFloat?

    init(
        backGroundColor: UIColor = .white,
        component: UIView,
        componentWidth: CGFloat?,
        componentHeight: CGFloat?
    ) {
        self.backGroundColor = backGroundColor
        self.component = component
        self.componentWidth = componentWidth
        self.componentHeight = componentHeight
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("no need to implement")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = self.backGroundColor

        view.addSubviews(
            self.component,

            constraints:
                self.component.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.component.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        )

        if let height = self.componentHeight {
            NSLayoutConstraint.activate([
                self.component.heightAnchor.constraint(equalToConstant: height),
            ])
        }

        if let width = self.componentWidth {
            NSLayoutConstraint.activate([
                self.component.widthAnchor.constraint(equalToConstant: width),
            ])
        }
    }
}
