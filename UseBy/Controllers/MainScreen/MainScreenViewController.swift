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
    let tabBar = TabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureTabBar()
    }

    func configureTabBar() {
        view.addSubview(tabBar.view)
        addChild(tabBar)
        tabBar.didMove(toParent: self)
    }
}
