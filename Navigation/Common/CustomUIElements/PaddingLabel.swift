import UIKit

class PaddingLabel: UILabel {

    var textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += textInsets.top + textInsets.bottom
            contentSize.width += textInsets.left + textInsets.right
            return contentSize
        }
    }

    override func drawText(in rect: CGRect) {
        self.setNeedsLayout()
        super.drawText(in: rect.inset(by: textInsets))
    }
}
