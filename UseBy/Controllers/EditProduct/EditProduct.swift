import Foundation
import UIKit

class EditProductViewController: UIViewController, ProductPageViewDelegate {
    private let productModel: ProductModel = ProductModel()
    private var product: Product

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let productView = ProductPageView(addButtonText: "save".localized)
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

    func didTapAddButton(value: ProductToCreate) {
        product.afterOpenening = value.afterOpenening
        product.expirationDate = value.expirationDate
        product.name = value.name
        product.openedDate = value.openedDate
        product.tag = value.tag
        product.useByDate = value.useByDate

        productModel.update(data: product, completion: {(_, _) in
            self.dismiss(animated: true, completion: nil)
        })
    }

    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
