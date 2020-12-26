import Foundation
import UIKit

class ValueFieldWithCheckbox: UIView {
    struct UIConstants {
        static let height: CGFloat = 60
        static let dividerHeight: CGFloat = 1
        static let iconMargin: CGFloat = 5
    }

    let nameLabel = UILabel()
    let checkboxIcon = IconView(name: "Checkbox", size: .medium, theme: .action)

    var isChecked: Bool {
        didSet {
            if isChecked {
                checkboxIcon.isHidden = false
            } else {
                checkboxIcon.isHidden = true
            }
        }
    }

    init(name: String) {
        isChecked = false
        super.init(frame: .zero)

        nameLabel.text = name

        self.snp.makeConstraints { (make) in
            make.height.equalTo(UIConstants.height)
        }

        addSubview(checkboxIcon)
        checkboxIcon.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
        }

        configureNameLabel()
        configureDivider()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureNameLabel() {
        nameLabel.textColor = Colors.mainTextColor
        nameLabel.font = Fonts.mainText
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
    }

    func configureDivider() {
        let divider: UIView = UIView()
        divider.backgroundColor = Colors.inputDividerColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)

        divider.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.dividerHeight)
            make.width.equalTo(self)
            make.bottom.equalTo(self).offset(-UIConstants.dividerHeight)
        }
    }
}
