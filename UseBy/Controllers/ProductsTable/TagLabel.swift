import Foundation
import UIKit

class TagLabel: UIView {
    struct UIConstants {
        static let padding: CGFloat = 25
        static let cornerRadius: CGFloat = 13
        static let height: CGFloat = 25
    }

    private var label = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(label)
        label.textColor = Colors.secondaryTextColor
        label.font = Fonts.smallHeadlineText

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
        }

        layer.cornerRadius = UIConstants.cornerRadius
        layer.borderWidth = 1
        layer.borderColor = Colors.secondaryTextColor.cgColor

        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.width.equalTo(self).offset(-UIConstants.padding)
        }
    }

    func setText(text: String) {
        label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
