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
        static let logOutButtonPadding: CGFloat = 20
    }

    private let emptyScreenLabel = UILabel()
    private let logOutButton = MainButton(
        text: "log-out".localized, theme: .pseudo
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureEmptyScreenLabel()
        configureLogOutButton()
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

    func configureLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(emptyScreenLabel.snp.bottom).offset(UIConstants.logOutButtonPadding)
            make.centerX.equalTo(view)
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).inset(UIConstants.logOutButtonPadding)
        }
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }

    @objc
    private func didTapLogOutButton() {
        GIDSignIn.sharedInstance()?.signOut()
        self.view.window?.rootViewController = MainAuthViewController()
    }
}
