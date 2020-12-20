import Foundation
import UIKit

class ProductsViewController: UIViewController {
    struct UIConstants {
        static let filtersOffset: CGFloat = 70
        static let padding: CGFloat = 40
        static let filtersHeight: CGFloat = 90
        static let controlsMargin: CGFloat = 10
    }

    private let emptyScreenLabel = UILabel()
    private let filters = FiltersViewController()
    private let productsTableVC = ProductsTableViewController()
    private let productModel: ProductModel = ProductModel()
    private var data: [Product]?

    init() {
        super.init(nibName: nil, bundle: nil)

        self.productsTableVC.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        let loader = Loader(lineWidth: 5)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.isAnimating = true

        view.addSubview(loader)
        loader.snp.makeConstraints {(make) in
            make.center.equalTo(self.view)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        configureFilters()
        configureTable()

        let filters = ProductFilters(searchByName: nil, isLiked: nil, isExpired: nil, tag: nil, sort: nil)
        productModel.get(filters: filters, completion: { (products, error) in
            if let products = products {
                self.data = products
                loader.isHidden = true
                self.productsTableVC.reloadTable()
                self.productsTableVC.view.isHidden = false
            }

            if let error = error {
                // Something
            }
        })
    }

    func configureEmptyScreenLabel() {
        emptyScreenLabel.text = "empty-screen".localized
        emptyScreenLabel.font = Fonts.largeTitleText
        emptyScreenLabel.textColor = Colors.secondaryTextColor
        emptyScreenLabel.textAlignment = .center
        view.addSubview(emptyScreenLabel)
        emptyScreenLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(view)
        }
    }

    func configureFilters() {
        view.addSubview(filters.view)
        addChild(filters)
        filters.didMove(toParent: self)
        filters.view.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.filtersOffset)
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.centerX.equalTo(view)
            make.height.equalTo(UIConstants.filtersHeight)
        }
    }

    func configureTable() {
        view.addSubview(productsTableVC.view)
        addChild(productsTableVC)
        productsTableVC.didMove(toParent: self)

        productsTableVC.view.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(filters.view.snp.bottom).offset(UIConstants.controlsMargin)
            make.bottom.equalTo(view)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
        }

        productsTableVC.view.isHidden = true
    }
}

extension ProductsViewController: ProductsViewControllerDelegate {
    func getData() -> [Product] {
        return self.data ?? []
    }
}
