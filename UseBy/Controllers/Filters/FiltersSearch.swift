import Foundation
import UIKit

class FiltersSearch: UIView {
    struct UIConstants {
        static let height: CGFloat = 35
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 20
    }

    let field: UITextField = UITextField()

    init() {
        super.init(frame: .zero)

        backgroundColor = Colors.filterControlBackground
        layer.cornerRadius = UIConstants.cornerRadius
        addSubview(field)

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
        }

        field.textColor = Colors.secondaryTextColor
        field.font = Fonts.mainText
        field.clearButtonMode =  .whileEditing
        field.borderStyle = .none
        field.placeholder = "search".localized

        field.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
            make.width.equalTo(self).offset(-UIConstants.padding)
            make.centerX.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
