import Foundation
import UIKit

class ExpirationDateLabel: UIView {
    struct UIConstants {
        static let buttonsOffset: CGFloat = 5
    }

    private var expiresLabel = UILabel()
    private var dateLabel = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(expiresLabel)
        addSubview(dateLabel)

        expiresLabel.font = Fonts.cardText
        dateLabel.font = Fonts.cardBoldText
        expiresLabel.text = "expires".localized

        expiresLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }

        dateLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(expiresLabel.snp.right).offset(UIConstants.buttonsOffset)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDate(date: String) {
        dateLabel.text = date
    }
}
