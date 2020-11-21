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
    }

    private let emptyScreenLabel = UILabel()
    private let button = FilterButton(text: "filters".localized)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureButtons()
    }

    func configureButtons() {
        view.addSubview(self.button)
        view.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
        }
    }
}
