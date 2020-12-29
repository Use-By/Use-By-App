import Foundation
import UIKit

protocol FiltersViewControllerDelegate: AnyObject {
    func applyFilters(filters: ProductFilters)
}

class FiltersViewController: UIViewController, ChangeFiltersViewControllerDelegate {
    struct UIConstants {
        static let padding: CGFloat = 40
        static let buttonsSpacing: CGFloat = 10
        static let filtersControlsMargin: CGFloat = 10
    }

    private let scrollView = UIScrollView()
    private let search = FiltersSearch()
    private let buttons = [
        FilterButton(
            text: "filters".localized,
            icon: Icon(name: "FiltersIcon", size: .medium)
        ),
        FilterButton(
            text: "liked".localized,
            icon: Icon(name: "LikeIcon", size: .medium)
        ),
        FilterButton(text: "expired".localized)
    ]
    private var filters: ProductFilters
    weak var delegate: FiltersViewControllerDelegate?

    init(filters: ProductFilters) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureSearch()
        configureButtons()
    }

    func configureSearch() {
        search.delegate = self
        view.addSubview(search)
        search.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }
    }

    func configureButtons() {
        let stackviewFields = UIStackView(arrangedSubviews: buttons)
        stackviewFields.axis = .horizontal
        stackviewFields.spacing = UIConstants.buttonsSpacing
        stackviewFields.translatesAutoresizingMaskIntoConstraints = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {(make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(search.snp.bottom).offset(UIConstants.filtersControlsMargin)
            make.height.equalTo(40)
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(stackviewFields)
        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }

        buttons[0].addTarget(self, action: #selector(didTapFiltersButton), for: .touchUpInside)
        buttons[1].addTarget(self, action: #selector(didTapLikedButton), for: .touchUpInside)
        buttons[2].addTarget(self, action: #selector(didTapExpiredButton), for: .touchUpInside)
    }

    @objc
    func didTapFiltersButton() {
        let changeFiltersVC = ChangeFiltersViewController(filters: filters)
        changeFiltersVC.delegate = self
        present(changeFiltersVC, animated: true, completion: nil)
    }

    @objc
    func didTapLikedButton() {
        filters.isLiked = !filters.isLiked
        self.delegate?.applyFilters(filters: filters)
        buttons[1].isActive = !buttons[1].isActive
    }

    @objc
    func didTapExpiredButton() {
        filters.isExpired = !filters.isExpired
        self.delegate?.applyFilters(filters: filters)
        buttons[2].isActive = !buttons[2].isActive
    }

    func applyFilters(filters: ProductFilters) {
        self.filters = filters
        self.delegate?.applyFilters(filters: filters)

        if filters.sort != nil {
            buttons[0].isActive = true
        } else {
            buttons[0].isActive = false
        }
    }
}

extension FiltersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filters.searchByName = searchText
        delegate?.applyFilters(filters: filters)
    }
}
