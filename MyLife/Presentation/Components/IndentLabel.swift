import UIKit

class IndentLabel: UILabel {
    let insets: UIEdgeInsets

    init(insets: UIEdgeInsets, frame: CGRect = .zero) {
        self.insets = insets
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += (insets.left + insets.right)
        intrinsicContentSize.height += (insets.top + insets.bottom)
        return intrinsicContentSize
    }
}
