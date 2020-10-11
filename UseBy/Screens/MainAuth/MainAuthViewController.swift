//
//  MainAuthViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit

class MainAuthViewController: UIViewController {
    private var contentView = UIScrollView()
    var signUpButton = MainButton(text: "Create account", theme: MainButton.ButtonTheme.action)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isOpaque = false
        view.backgroundColor = UIColor.mainBGColor()

        setContent()

        let appNameLabel = AppName()
        view.addSubview(appNameLabel)
        appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appNameLabel.centerYAnchor.constraint(equalTo: view.topAnchor).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        appNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(self.signUpButton)
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        signUpButton.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.signUpButton.initActionThemeStyles()
    }

    private func setContent() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
