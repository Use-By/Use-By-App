import Foundation
import UIKit

protocol ProductPageViewDelegate: AnyObject {
    func didTapAddButton()
    func didTapCloseIcon()
}

class ProductPageView: UIView {
    struct UIConstants {
        static let buttonPadding: CGFloat = 40
        static let buttonBottomMargin: CGFloat = 40
        static let closeIconMargin: CGFloat = 20
    }

    private let addButton: MainButton
    private let closeIcon = IconView(
        name: "CloseIcon",
        size: .large
    )
    weak var delegate: ProductPageViewDelegate?

    init(addButtonText: String) {
        addButton = MainButton(
            text: addButtonText,
            theme: .normal
        )

        super.init(frame: .zero)

        backgroundColor = Colors.mainBGColor

        configureAddButton()
        configureCloseIcon()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureAddButton() {
        addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(self).offset(-UIConstants.buttonPadding)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-UIConstants.buttonBottomMargin)
        }
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    func configureCloseIcon() {
        addSubview(closeIcon)
        closeIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(UIConstants.closeIconMargin)
            make.right.equalTo(self).offset(-UIConstants.closeIconMargin)
        }
        closeIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseIcon)))
    }

    @objc
    func didTapAddButton() {
        self.delegate?.didTapAddButton()
    }

    @objc
    func didTapCloseIcon() {
        self.delegate?.didTapCloseIcon()
    }
}
