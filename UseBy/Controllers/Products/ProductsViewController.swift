import Foundation
import UIKit

class FirstScreenView: UIView {
    struct UIConstants {
        static let imageHeight: CGFloat = 250
        static let labelMargin: CGFloat = 10
        static let arrowHeight: CGFloat = 200
        static let arrowWidth: CGFloat = 150
        static let arrowCenterOffset: CGFloat = 50
        static let height: CGFloat = 500
    }

    private let label = UILabel()
    private let image = UIImageView(image: UIImage(named: "FirstOpen"))
    private let arrow = UIImageView(image: UIImage(named: "SelectArrow"))

    init() {
        super.init(frame: .zero)

        self.snp.makeConstraints {(make) in
            make.height.equalTo(UIConstants.height)
        }

        addSubview(image)
        image.snp.makeConstraints {(make) in
            make.width.equalTo(UIConstants.imageHeight)
            make.height.equalTo(UIConstants.imageHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        label.text = "empty-screen".localized
        label.font = Fonts.largeTitleText
        label.textColor = Colors.secondaryTextColor
        label.textAlignment = .center
        addSubview(label)
        label.snp.makeConstraints {(make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(image.snp.bottom).offset(UIConstants.labelMargin)
        }

        addSubview(arrow)
        arrow.snp.makeConstraints {(make) in
            make.width.equalTo(UIConstants.arrowWidth)
            make.height.equalTo(UIConstants.arrowHeight)
            make.centerX.equalTo(self).offset(UIConstants.arrowCenterOffset)
            make.top.equalTo(label.snp.bottom)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductsViewController: UIViewController {
    struct UIConstants {
        static let filtersOffset: CGFloat = 70
        static let padding: CGFloat = 40
        static let filtersHeight: CGFloat = 90
        static let controlsMargin: CGFloat = 10
        static let loaderLineWidth: CGFloat = 5
        static let loaderHeight: CGFloat = 50
        static let arrowBottomOffset: CGFloat = 90
    }

    private let emptyScreen = FirstScreenView()
    private let nothingFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "filters-empty".localized
        label.font = Fonts.largeTitleText
        label.textColor = Colors.secondaryTextColor
        label.textAlignment = .center
        return label
    }()
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
        configureNothingFoundLabel()

        loadProducts()
    }

    func hasFilters() -> Bool {
        if self.filters.isExpired {
            return true
        }

        if self.filters.isLiked {
            return true
        }

        if let name = self.filters.searchByName, name != "" {
            return true
        }

        if let tag = self.filters.tag, tag != "" {
            return true
        }

        if self.filters.sort != nil {
            return true
        }

        return false
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
                    self.emptyScreen.isHidden = true
                    self.nothingFoundLabel.isHidden = true
                } else {
                    self.productsTableVC.view.isHidden = true

                    if self.hasFilters(), self.emptyScreen.isHidden {
                        self.nothingFoundLabel.isHidden = false
                    } else {
                        self.emptyScreen.isHidden = false
                    }
                }
            }

            if let error = error {
                _ = Alert(
                    title: "error".localized,
                    message: getProductErrorText(error: error),
                    action: .none
                )
            }
        })
    }

    func configureEmptyScreenLabel() {
        view.addSubview(emptyScreen)
        emptyScreen.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.bottom.equalTo(view)
            make.bottom.equalTo(view).offset(-UIConstants.arrowBottomOffset)
        }
        emptyScreen.isHidden = true
    }

    func configureNothingFoundLabel() {
        view.addSubview(nothingFoundLabel)
        nothingFoundLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(50)
        }
        nothingFoundLabel.isHidden = true
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
        productModel.like(id: id, liked: liked, completion: {(error) in
            if let error = error {
                _ = Alert(
                    title: "error".localized,
                    message: getProductErrorText(error: error),
                    action: .none
                )

                return
            }

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
