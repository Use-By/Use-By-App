//
//  MainAuthViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit
import SnapKit

class MainAuthViewController: UIViewController {
    struct MainAuthViewUIConstants {
        static let backgroundCircleWidth = 500
        static let bottomCircleWidth = 600
        static let buttonsSpacing: CGFloat = 15
        static let signupButtonMargin: CGFloat = 45
        static let stackViewMargin: CGFloat = -100
        static let stackViewPadding: CGFloat = 20
        static let alreadySignUpButtonMargin: CGFloat = -50
    }

    private let appNameLabel = AppName()
    private let appDescriptionLabel = UILabel()
    private let googleSignUpButton = MainButton(
        text: "create-account-google".localized,
        theme: .social,
        icon: Icon(name: "Google", size: .small, theme: .inversed)
    )
    private let signUpButton = MainButton(text: "create-account".localized, theme: .action)
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )
    private let backgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.mainActionBGColor
    )
    private let bottomBackgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.secondaryActionBGColor
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor
        configureBottomCircles()
        configureAppDescriptionLabel()
        configureAuthButtons()
    }

    func configureAuthButtons() {
        let arrangedSubviews = [appNameLabel, appDescriptionLabel, googleSignUpButton]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)//massive of buttons
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = MainAuthViewUIConstants.buttonsSpacing
        appNameLabel.textAlignment = .center
        view.addSubview(stackView)
        view.addSubview(signUpButton)

        signUpButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(stackView)
            make.centerX.equalTo(stackView)
            make.centerY.equalTo(stackView.snp.bottom).offset(MainAuthViewUIConstants.signupButtonMargin)
        }
        googleSignUpButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
        }
        stackView.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(MainAuthViewUIConstants.stackViewMargin)
            make.width.equalTo(view).inset(
                UIEdgeInsets(
                    top: 0,
                    left: MainAuthViewUIConstants.stackViewPadding,
                    bottom: 0,
                    right: MainAuthViewUIConstants.stackViewPadding
                )
            )
        }

        view.addSubview(alreadySignUpButton)
        alreadySignUpButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(MainAuthViewUIConstants.alreadySignUpButtonMargin)
            make.centerX.equalTo(view)
        }
    }

    func configureBottomCircles() {
        view.addSubview(backgroundCircle)
        view.addSubview(bottomBackgroundCircle)
        backgroundCircle.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
        }
        bottomBackgroundCircle.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
        }
    }

    func configureAppDescriptionLabel() {
        appDescriptionLabel.text = "app-description".localized
        appDescriptionLabel.font = Fonts.mainText
        appDescriptionLabel.textColor = Colors.mainTextColor
        appDescriptionLabel.textAlignment = .center
    }

    override func viewDidLayoutSubviews() {
        signUpButton.initActionThemeStyles()
    }
}

/*
 class MainAuthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     var profile = UITableView()
     let identifire = "MyCell"
     var array = ["name".localized, "email".localized, "change-password".localized, "send-feedback".localized]

     private let appNameLabel = AppName()
     private let appDescriptionLabel = UILabel()
     override func viewDidLoad() {
         super.viewDidLoad()
         //configureAuthButtons()
         createTable()
     }

     func createTable () {

         self.profile = UITableView(frame: view.bounds, style: .plain)
         profile.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
         self.profile.delegate = self
         self.profile.dataSource = self
         profile.autoresizingMask = [.flexibleWidth, .flexibleHeight]

         //profile.top.equelTo
         view.addSubview(profile)

     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4

     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) // create cell
         let number = array[indexPath.row]

         cell.textLabel?.text = number//trans inf
         cell.accessoryType = .disclosureIndicator
         return cell
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60.0
     }
     private let logOutButtom = MainButton(
         text: "log-out".localized,
         theme: .social
     )
     /*
     func configureAuthButtons() {
         let arrangedSubviews = [logOutButtom]
         let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
         stackView.axis = .vertical
         stackView.distribution = .fill
         /*stackView.spacing = MainAuthViewUIConstants.buttonsSpacing*/
         appNameLabel.textAlignment = .center
         view.addSubview(logOutButtom)

         logOutButtom.snp.makeConstraints {(make) -> Void in
             make.height.equalTo(MainButton.buttonHeight)
             make.width.equalTo(stackView)
             make.centerX.equalTo(stackView)
         }
     }*/

 }
 */
