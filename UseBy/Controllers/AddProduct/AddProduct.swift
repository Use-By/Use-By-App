import Foundation
import UIKit

protocol AddProductPageViewDelegate: AnyObject {
    func didCreatedProduct()
}

class AddProductViewController: UIViewController, ProductPageViewDelegate {
    private let productModel: ProductModel = ProductModel()
    private let productView = ProductPageView(addButtonText: "add".localized)
    private var data: ProductToCreate = ProductToCreate(
        name: "",
        tag: nil,
        openedDate: Date(),
        afterOpenening: nil,
        useByDate: nil,
        photo: nil,
        isLiked: false,
        expirationDate: nil
    )
    weak var delegate: AddProductPageViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        productView.delegate = self

        addChild(productView)
        productView.didMove(toParent: self)
        view.addSubview(productView.view)
        productView.view.snp.makeConstraints {(make) in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view)
            make.width.equalTo(self.view)
        }

        productView.fillData(with: data.photo, product: data)
    }

    func didTapAddButton(value: ProductPageInfo) {
        data.name = value.name
        data.tag = value.tag
        data.openedDate = value.openedDate
        data.afterOpenening = value.afterOpenening
        data.useByDate = value.useByDate
        data.photo = value.photo
        data.expirationDate = getExpirationDate(useByDate: value.useByDate, afterOpeningDate: value.afterOpenening)

        if let photo = value.photo {
            productModel.uploadPhoto(photo: photo, completion: {(photoUrl, error) in
                if let error = error {
                    _ = Alert(
                        title: "error".localized,
                        message: getProductErrorText(error: error),
                        action: .none
                    )

                    self.productView.stopLoading()

                    return
                }

                guard let photoUrl = photoUrl else {
                    _ = Alert(
                        title: "error".localized,
                        message: getProductErrorText(error: .unknownError),
                        action: .none
                    )

                    self.productView.stopLoading()

                    return
                }

                self.data.photoUrl = photoUrl
                self.productModel.create(data: self.data, completion: { (_, error) in
                    if let error = error {
                        _ = Alert(
                            title: "error".localized,
                            message: getProductErrorText(error: error),
                            action: .none
                        )
                        return
                    }

                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.didCreatedProduct()
                })
            })

            return
        }

        productModel.create(data: data, completion: { (_, error) in
            if let error = error {
                _ = Alert(
                    title: "error".localized,
                    message: getProductErrorText(error: error),
                    action: .none
                )

                self.productView.stopLoading()

                return
            }

            self.dismiss(animated: true, completion: nil)
            self.delegate?.didCreatedProduct()
        })
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
