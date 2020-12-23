import Foundation
import UIKit

class ValuePickerForm: UIViewController {
    struct UIConstants {
        static let height: CGFloat = 60
        static let dividerHeight: CGFloat = 1
        static let iconMargin: CGFloat = 5
    }

    let nameLabel = UILabel()
    let valueLabel = UILabel()
    let arrowIcon = IconView(name: "RightArrow", size: .small, theme: .secondary)
    var valuePlaceholder: String = ""

    init(name: String, placeholder: String = "") {
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = name
        valuePlaceholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.snp.makeConstraints { (make) in
            make.height.equalTo(UIConstants.height)
        }

        view.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(view)
            make.centerY.equalTo(view)
        }

        configureNameLabel()
        configureValueLabel()
        configureDivider()
    }

    func configureNameLabel() {
        nameLabel.textColor = Colors.mainTextColor
        nameLabel.font = Fonts.mainText
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.centerY.equalTo(view)
        }
    }

    func configureValueLabel() {
        valueLabel.textColor = Colors.secondaryTextColor
        valueLabel.font = Fonts.mainText
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(arrowIcon.snp.left).offset(-UIConstants.iconMargin)
            make.centerY.equalTo(view)
        }
    }

    func configureDivider() {
        let divider: UIView = UIView()
        divider.backgroundColor = Colors.inputDividerColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)

        divider.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.dividerHeight)
            make.width.equalTo(view)
            make.bottom.equalTo(view).offset(-UIConstants.dividerHeight)
        }
    }

    func setValue(value: String?) {
        if let value = value {
            valueLabel.text = value
        } else {
            valueLabel.text = valuePlaceholder
        }
    }
}
