//
//  MainScreenViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/17/20.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    private let emptyScreenLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

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
        }
    }
}
