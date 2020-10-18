//
//  MainScreenViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/17/20.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    private let appNameLabel = AppName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(appNameLabel)
        appNameLabel.textAlignment = .center
        appNameLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
    }
}
