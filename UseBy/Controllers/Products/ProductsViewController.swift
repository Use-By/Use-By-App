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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureFilters()
        configureEmptyScreenLabel()
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
    }
}
