import Foundation
import UIKit

protocol AddProductPageViewDelegate: AnyObject {
    func didCreatedProduct()
}

class AddProductViewController: UIViewController, ProductPageViewDelegate {
    private let productModel: ProductModel = ProductModel()
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

        let productView = ProductPageView(addButtonText: "add".localized)
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
        // TODO 
        data.photo = value.photo
        data.expirationDate = getExpirationDate(useByDate: value.useByDate, afterOpeningDate: value.afterOpenening)
        
        productModel.create(data: data, completion: { (_, _) in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.didCreatedProduct()
        })
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
