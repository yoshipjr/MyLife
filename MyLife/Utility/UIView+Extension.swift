import UIKit

extension UIView {
    static var identifier: String {
        self.className
    }

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func addSubviews(_ views: UIView..., constraints: NSLayoutConstraint...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.forEach { $0.isActive = true }
    }
}
