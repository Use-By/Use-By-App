import Foundation
import UIKit

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
        expirationDate: Date()
    )

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

    @objc
    func didTapAddButton() {
        productModel.create(data: data, completion: { (_, _) in
            self.dismiss(animated: true, completion: nil)
        })
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
