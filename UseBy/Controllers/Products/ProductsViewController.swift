import Foundation
import UIKit

class ProductsViewController: UIViewController {
    struct UIConstants {
        static let filtersOffset: CGFloat = 70
        static let padding: CGFloat = 40
        static let filtersHeight: CGFloat = 90
        static let controlsMargin: CGFloat = 10
        static let loaderLineWidth: CGFloat = 5
        static let loaderHeight: CGFloat = 50
    }

    private let emptyScreenLabel = UILabel()
    private let loader: Loader = {
        let loader = Loader(lineWidth: UIConstants.loaderLineWidth)
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()

    private var filters = ProductFilters(searchByName: nil, isLiked: false, isExpired: false, tag: nil, sort: nil)
    private let filtersVC: FiltersViewController
    private let productsTableVC = ProductsTableViewController()
    private let productModel: ProductModel = ProductModel()
    private var data: [Product]?

    init() {
        filtersVC = FiltersViewController(filters: self.filters)
        super.init(nibName: nil, bundle: nil)

        filtersVC.delegate = self
        productsTableVC.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor
        loader.isAnimating = true

        view.addSubview(loader)
        loader.snp.makeConstraints {(make) in
            make.center.equalTo(self.view)
            make.width.equalTo(UIConstants.loaderHeight)
            make.height.equalTo(UIConstants.loaderHeight)
        }

        configureFilters()
        configureTable()
        configureEmptyScreenLabel()

        loadProducts()
    }

    func loadProducts() {
        productsTableVC.setLoader(isHidden: false)
        productModel.get(filters: filters, completion: { (products, error) in
            if let products = products {
                self.data = products
                self.loader.isHidden = true
                self.productsTableVC.setLoader(isHidden: true)

                if products.count != 0 {
                    self.productsTableVC.reloadTable()
                    self.productsTableVC.view.isHidden = false
                    self.emptyScreenLabel.isHidden = true
                } else {
                    self.productsTableVC.view.isHidden = true
                    self.emptyScreenLabel.isHidden = false
                }
            }

            if let error = error {
                // TODO error
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
        emptyScreenLabel.isHidden = true
    }

    func configureFilters() {
        view.addSubview(filtersVC.view)
        addChild(filtersVC)
        filtersVC.didMove(toParent: self)
        filtersVC.view.snp.makeConstraints { (make) -> Void in
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
            make.top.equalTo(filtersVC.view.snp.bottom).offset(UIConstants.controlsMargin)
            make.bottom.equalTo(view)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
        }

        productsTableVC.view.isHidden = true
    }
}

extension ProductsViewController: ProductsViewControllerDelegate {
    func didTapDeleteButton(id: String) {
        let alert = UIAlertController(
            title: "delete-warning".localized, message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "no".localized, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "yes".localized, style: .default, handler: {(_) in
            self.productModel.delete(id: id, completion: {(_) in
                self.loadProducts()
            })
        }))

        present(alert, animated: true, completion: nil)
    }

    func didTapLikeButton(id: String, liked: Bool) {
        productModel.like(id: id, liked: liked, completion: {(_) in
            self.loadProducts()
        })
    }

    func getData() -> [Product] {
        return self.data ?? []
    }
}

extension ProductsViewController: FiltersViewControllerDelegate {
    func applyFilters(filters: ProductFilters) {
        self.filters = filters
        loadProducts()
    }
}
