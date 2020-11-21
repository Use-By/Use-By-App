//
//  MainScreenViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/17/20.
//

import Foundation
import UIKit
import GoogleSignIn

class MainScreenViewController: UIViewController {
    struct UIConstants {
    }

    private let emptyScreenLabel = UILabel()
    let tabBar = TabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureEmptyScreenLabel()
        configureTabBar()
    }

    func configureTabBar() {
//        view.addSubview(tabBar.view)
//        addChild(tabBar)
//        tabBar.didMove(toParent: self)
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
}
