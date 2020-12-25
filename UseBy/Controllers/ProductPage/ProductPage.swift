import Foundation
import UIKit

protocol ProductPageViewDelegate: AnyObject {
    func didTapAddButton()
    func didTapCloseIcon()
    func nameChanged(value: String)
    func tagChanged(value: String)
}

class ProductPageView: UIViewController {
    struct UIConstants {
        static let buttonBottomMargin: CGFloat = 40
        static let closeIconMargin: CGFloat = 20
        static let formsSpacing: CGFloat = 0
        static let padding: CGFloat = 40
        static let topMargin: CGFloat = 10
        static let formsMargin: CGFloat = 10
        static let photoHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 14
    }

    private let addButton: MainButton
    private let closeIcon = IconView(
        name: "CloseIcon",
        size: .large
    )
    weak var delegate: ProductPageViewDelegate?

    private let photo = ProductPagePhoto()
    private let nameField = TextField(purpose: .name)
    private let openedField = DateValuePickerForm(name: "opened".localized)
    private let afterOpeningField = DateValuePickerForm(name: "after-opening".localized, placeholder: "select".localized)
    private let useByField = DateValuePickerForm(name: "use-by".localized, placeholder: "select".localized)
    private let tagField = TextField(purpose: .tag)

    init(addButtonText: String) {
        addButton = MainButton(
            text: addButtonText,
            theme: .normal
        )

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = Colors.mainBGColor

        configureAddButton()
        configureCloseIcon()
        configurePhoto()
        configureForms()
    }

    func configurePhoto() {
        view.addSubview(photo)
        photo.snp.makeConstraints {(make) in
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.height.equalTo(UIConstants.photoHeight)
            make.top.equalTo(closeIcon.snp.bottom).offset(UIConstants.topMargin)
        }
        photo.layer.cornerRadius = UIConstants.cornerRadius
    }

    func configureForms() {
        [openedField, afterOpeningField, useByField].forEach {
            self.addChild($0)
            $0.didMove(toParent: self)
        }

        guard let openedFieldView = openedField.view,
              let afterOpeningFieldView = afterOpeningField.view,
              let useByFieldView = useByField.view else {
            return
        }

        [nameField, tagField].forEach {
            $0.textField.delegate = self
        }

        let arrangedSubviews = [nameField, openedFieldView, afterOpeningFieldView, useByFieldView, tagField]
        let stackViewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackViewFields.axis = .vertical
        stackViewFields.spacing = UIConstants.formsSpacing

        view.addSubview(stackViewFields)
        stackViewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.centerX.equalTo(view)
            make.top.equalTo(photo.snp.bottom).offset(UIConstants.formsMargin)
        }
    }

    func configureAddButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-UIConstants.buttonBottomMargin)
        }
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    func configureCloseIcon() {
        view.addSubview(closeIcon)
        closeIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.closeIconMargin)
            make.right.equalTo(view).offset(-UIConstants.closeIconMargin)
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

    func fillData(with photoUrl: String?, product: ProductInfo) {
        setData(product: product)

        if let photoUrl = photoUrl {
            photo.setPhoto(with: photoUrl)
        } else {
            photo.setEmptyPhotoIcon()
        }
    }

    func fillData(with photoData: Data?, product: ProductInfo) {
        setData(product: product)

        if let photoData = photoData {
            photo.setPhoto(with: photoData)
        } else {
            photo.setEmptyPhotoIcon()
        }
    }

    private func setData(product: ProductInfo) {
        openedField.setValue(value: product.openedDate)
        afterOpeningField.setValue(value: product.afterOpenening)
        useByField.setValue(value: product.useByDate)
        nameField.textField.insertText(product.name)

        if let tag = product.tag {
            tagField.textField.insertText(tag)
        }
    }
}

extension ProductPageView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case TextField.TextFieldPurpose.name.rawValue:
            self.delegate?.nameChanged(value: textField.text ?? "")

        case TextField.TextFieldPurpose.tag.rawValue:
            self.delegate?.tagChanged(value: textField.text ?? "")

        default:
            break
        }
    }
}
