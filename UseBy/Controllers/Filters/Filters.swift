//
//  Filters.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/21/20.
//

import Foundation
import UIKit

class FiltersViewController: UIViewController {
    struct UIConstants {
        static let padding: CGFloat = 40
        static let buttonsSpacing: CGFloat = 10
        static let filtersControlsMargin: CGFloat = 10
    }

    private let emptyScreenLabel = UILabel()
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureSearch()
        configureButtons()
    }

    func configureSearch() {
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
        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.top.equalTo(search.snp.bottom).offset(UIConstants.filtersControlsMargin)
        }

        buttons[0].addTarget(self, action: #selector(didTapFiltersButton), for: .touchUpInside)
    }

    @objc
    func didTapFiltersButton() {
        present(ChangeFiltersViewController(), animated: true, completion: nil)
    }
}
