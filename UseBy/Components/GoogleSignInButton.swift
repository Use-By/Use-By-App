//
//  GoogleSignInButton.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/22/20.
//

import Foundation
import UIKit
import GoogleSignIn

class GoogleSignInButton: UIViewController {
    private let googleSignInButton = MainButton(
        text: "create-account-google".localized,
        theme: .social,
        icon: Icon(name: "Google", size: .small, theme: .inversed)
    )

    override func viewDidLoad() {
        view.addSubview(googleSignInButton)
        googleSignInButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view)
            make.center.equalTo(view)
        }
        googleSignInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }

    @objc
    private func didTapSignInButton() {
        GIDSignIn.sharedInstance().signIn()
    }
}
