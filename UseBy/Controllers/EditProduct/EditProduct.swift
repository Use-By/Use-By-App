import Foundation
import UIKit

class EditProductViewController: UIViewController, ProductPageViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        let productView = ProductPageView(addButtonText: "save".localized)
        productView.delegate = self

        view.addSubview(productView)
        productView.snp.makeConstraints {(make) in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view)
            make.width.equalTo(self.view)
        }
    }

    @objc
    func didTapAddButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
