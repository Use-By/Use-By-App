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
    }

    private let emptyScreenLabel = UILabel()
    private let button = FilterButton(
        text: "filters".localized,
        icon: Icon(name: "FiltersIcon", size: .medium)
    )
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

        configureButtons()
    }

    func configureButtons() {
        let stackviewFields = UIStackView(arrangedSubviews: buttons)
        stackviewFields.axis = .horizontal
        stackviewFields.spacing = UIConstants.buttonsSpacing
        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.top.equalTo(view)
        }

        buttons[0].addTarget(self, action: #selector(didTapFiltersButton), for: .touchUpInside)
    }

    @objc
    func didTapFiltersButton() {
        present(ChangeFiltersViewController(), animated: true, completion: nil)
    }
}
