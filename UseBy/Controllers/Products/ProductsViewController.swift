import Foundation
import UIKit

class ProductsViewController: UIViewController {
    struct UIConstants {
        static let filtersOffset: CGFloat = 70
        static let padding: CGFloat = 20
        static let filtersHeight: CGFloat = 85
    }

    private let emptyScreenLabel = UILabel()
    private let filters = FiltersViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureEmptyScreenLabel()
        configureFilters()
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
            make.width.equalTo(view)
            make.left.equalTo(view).offset(UIConstants.padding)
            make.height.equalTo(UIConstants.filtersHeight)
        }
    }
}
