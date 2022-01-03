import UIKit

extension UIView {
    static var identifier: String {
        self.className
    }

    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}
