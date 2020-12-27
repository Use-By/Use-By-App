import Foundation
import UIKit

protocol ProductPageViewDelegate: AnyObject {
    func didTapAddButton(value: ProductPageInfo)
    func didTapCloseIcon()
}

enum ProductPageValue: Int {
    case opened = 0
    case afterOpening
    case useBy
}

struct ProductPageInfo {
    var photoUrl: String?
    var name: String
    var tag: String?
    var openedDate: Date?
    var afterOpenening: Date?
    var useByDate: Date?
    var photo: Data?
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
    private let openedField: DateValuePickerField = {
        let field = DateValuePickerField(
            name: "opened".localized
        )
        field.tag = ProductPageValue.opened.rawValue

        return field
    }()
    private let afterOpeningField: DateValuePickerField = {
        let field = DateValuePickerField(
            name: "after-opening".localized,
            placeholder: "select".localized
        )
        field.tag = ProductPageValue.afterOpening.rawValue

        return field
    }()
    private let useByField: DateValuePickerField = {
        let field = DateValuePickerField(
            name: "use-by".localized,
            placeholder: "select".localized
        )
        field.tag = ProductPageValue.useBy.rawValue

        return field
    }()
    private let tagField = TextField(purpose: .tag)
    private var photoUrl: String?

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
        photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEditImage)))
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
        let product = ProductPageInfo(
            photoUrl: photoUrl,
            name: nameField.textField.text ?? "",
            tag: tagField.textField.text,
            openedDate: openedField.formValue,
            afterOpenening: afterOpeningField.formValue,
            useByDate: useByField.formValue,
            photo: photo.imageView.image?.pngData()
        )
        self.delegate?.didTapAddButton(value: product)
    }

    @objc
    func didTapCloseIcon() {
        self.delegate?.didTapCloseIcon()
    }

    func fillData(with photoUrl: String?, product: ProductInfo) {
        setData(product: product)

        if let photoUrl = photoUrl {
            photo.setPhoto(with: photoUrl)
            self.photoUrl = photoUrl
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
        nameField.textField.text = product.name

        if let tag = product.tag {
            tagField.textField.text = tag
        }
    }

    @objc
    func didTapEditImage() {
        let imageVC = UIImagePickerController()
        imageVC.sourceType = .photoLibrary
        imageVC.delegate = self
        imageVC.allowsEditing = true
        present(imageVC, animated: true, completion: nil)
    }
}

extension ProductPageView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {

        if let image = info[.editedImage] as? UIImage {
            photo.setPhoto(with: image)
            photoUrl = nil
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
