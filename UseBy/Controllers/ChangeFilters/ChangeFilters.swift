import Foundation
import UIKit

class ChangeFiltersViewController: UIViewController {
    struct UIConstants {
        static let buttonsSpacing: CGFloat = 20
        static let buttonBottomMargin: CGFloat = 40
        static let buttonPadding: CGFloat = 20
        static let titleMargin: CGFloat = 20
    }

    private let titleLabel = MainScreenTitle(labelType: .filterBy)
    private let applyButton = MainButton(
        text: "apply".localized,
        theme: .normal
    )
    private let resetButton = MainButton(
        text: "reset".localized,
        theme: .pseudo
    )
    private let closeIcon = IconView(
        name: "CloseIcon",
        size: .large
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureButtons()
        configureTitle()
    }

    func configureButtons() {
        let arrangedSubviews = [resetButton, applyButton]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .horizontal
        stackviewFields.spacing = UIConstants.buttonsSpacing
        stackviewFields.distribution = .fillEqually
        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.bottom.equalTo(view).offset(-UIConstants.buttonBottomMargin)
            make.left.equalTo(view).offset(UIConstants.buttonPadding)
            make.right.equalTo(view).offset(-UIConstants.buttonPadding)
        }

        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
    }

    func configureTitle() {
        view.addSubview(closeIcon)
        closeIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.titleMargin)
            make.right.equalTo(view).offset(-UIConstants.titleMargin)
        }
        closeIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseIcon)))

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.titleMargin)
            make.left.equalTo(view).offset(UIConstants.titleMargin)
        }
    }

    @objc
    func didTapResetButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapApplyButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
