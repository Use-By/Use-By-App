import Foundation
import UIKit

protocol EditProductPageViewDelegate: AnyObject {
    func didEditedProduct()
}

class EditProductViewController: UIViewController, ProductPageViewDelegate {
    private let productModel: ProductModel = ProductModel()
    private var product: Product
    private let productView = ProductPageView(addButtonText: "save".localized)

    weak var delegate: EditProductPageViewDelegate?

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        productView.fillData(with: product.photoUrl, product: product)
    }

    func didTapAddButton(value: ProductPageInfo) {
        product.afterOpenening = value.afterOpenening
        product.expirationDate = getExpirationDate(useByDate: value.useByDate, afterOpeningDate: value.afterOpenening)
        product.name = value.name
        product.openedDate = value.openedDate
        product.tag = value.tag
        product.useByDate = value.useByDate

        if value.photoUrl == nil, let photo = value.photo {
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

                self.product.photoUrl = photoUrl
                self.productModel.update(data: self.product, completion: {(_, error) in
                    if let error = error {
                        _ = Alert(
                            title: "error".localized,
                            message: getProductErrorText(error: error),
                            action: .none
                        )
                        return
                    }

                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.didEditedProduct()
                })
            })

            return
        }

        productModel.update(data: product, completion: {(_, error) in
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
            self.delegate?.didEditedProduct()
        })
    }

    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
