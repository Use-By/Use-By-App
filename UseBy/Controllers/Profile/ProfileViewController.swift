//
//  ProfileViewController.swift
//  UseBy
//
//  Created by Admin on 25.10.2020.
//

import Foundation
import UIKit
import SnapKit
import MessageUI

class ProfileViewController: UIViewController {
    private var userModel: UserModel?
    private var googleAuth: Bool?
    private var user: User?

    struct UIConstants {
        static let topTableView: CGFloat = 100.0
        static var heightTableView: CGFloat = 240.0
        static let spaceBetweenTableAndLogout: CGFloat = 30
        static let pageInsetMargin: CGFloat = 20
    }

    lazy private var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileSettingsCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()

    private var titleOfCellArray = ["name".localized, "email".localized,
    "change-password".localized, "send-feedback".localized]
    private var userDataArray: [String]?

    private let logOutButton = MainButton(
        text: "log-out".localized,
        theme: .pseudo
    )

    private lazy var composer = MFMailComposeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        userModel = UserModel()
        setUserData()
        self.googleAuth = user?.authWithGoogle
        if googleAuth ?? true {
            titleOfCellArray = ["name".localized, "email".localized,
            "send-feedback".localized]
            UIConstants.heightTableView = 180
        }
        configureProfileView()
        view.backgroundColor = Colors.mainBGColor
        configureLogOutButton()
    }

    func setUserData() {
        guard let user = userModel?.get() else {
            _ = Alert(title: "ops".localized,
                  message: "something_went_wrong".localized,
                  placeholder1: nil, placeholder2: nil, action: .none)
            return
        }
        self.user = user
        self.userDataArray = [user.name, user.email]
    }

    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            _ = Alert(title: "ops".localized,
                  message: "you_don't_have_mail_app_on_your_phone".localized,
                  placeholder1: nil, placeholder2: nil, action: .none)
            return
        }
        composer.mailComposeDelegate = self
        composer.setToRecipients(["use_by@gmail.com"])
        present(composer, animated: true)
    }

    func configureProfileView() {
        profileTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(UIConstants.topTableView)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(UIConstants.heightTableView)
        }
    }

    func configureLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).inset(UIConstants.pageInsetMargin)
            make.centerX.equalTo(view)
            make.top.equalTo(profileTableView.snp.bottom).offset(UIConstants.spaceBetweenTableAndLogout)
        }
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }

    @objc
    private func didTapLogOutButton() {
        userModel?.signOut()

        if let router = self.navigationController as? Router {
            router.goToMainAuthScreen()
        }
    }

    func saveName (name: [String]) {
        userModel!.changeName(newName: name[0]) { [weak self] error in
             DispatchQueue.main.async {
                if error != nil {
                    _ = Alert(title: "ops".localized,
                          message: "something_went_wrong".localized,
                          placeholder1: nil, placeholder2: nil, action: .none)
                }
                self?.user?.name = name[0]
                self?.setUserData()
                self?.profileTableView.reloadData()
             }}
    }

    func saveEmail (email: [String]) {
        userModel!.changeName(newName: email[0]) { [weak self] error in
             DispatchQueue.main.async {
                if error != nil {
                   _ = Alert(title: "ops".localized,
                         message: "something_went_wrong".localized,
                         placeholder1: nil, placeholder2: nil, action: .none)
                }
                self?.user?.email = email[0]
                self?.setUserData()
                self?.profileTableView.reloadData()
             }
        }
    }

    func savePassword (password: [String]) {
        userModel!.changePassword(newPassword: password[0]) { [weak self] error in
             DispatchQueue.main.async {
                if error != nil {
                    _ = Alert(title: "ops".localized,
                          message: "something_went_wrong".localized,
                          placeholder1: nil, placeholder2: nil, action: .none)
                }
                self?.user?.email = password[0]
                self?.setUserData()
                self?.profileTableView.reloadData()
             }
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newNameAlert = AlertController(title: "new-name".localized, message: nil,
                                               placeholder1: "put-your-name".localized, changeWhat: .changeName,
                                               saveDataFromAlert: saveName)
            present(newNameAlert, animated: true, completion: nil)
        case 1:
            if !(googleAuth ?? false) {
                let newEmailAlert = AlertController(title: "new-email".localized, message: nil, placeholder1:
                                                        "input-your-new-email-here".localized, changeWhat:
                                                            .changeEmail, saveDataFromAlert: saveEmail)
                present(newEmailAlert, animated: true, completion: nil)
            }

        case 2:
            if googleAuth ?? false {
                showMailComposer()
            } else {
            let newPasswordAlert = AlertController(title: "new-password".localized, message: nil,
                                                   placeholder1: "input-your-new-password-here".localized,
                                                   placeholder2: "confirm-your-new-password".localized,
                                                   changeWhat: .changePassword, saveDataFromAlert: savePassword)
            present(newPasswordAlert, animated: true, completion: nil)
        }
        default:
            showMailComposer()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleOfCellArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingsCell",
                                                       for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }

        guard let userDataArray = self.userDataArray else {
            return UITableViewCell()
        }

        if indexPath.row == 0 {
            cell.fillCell(titleLabel: titleOfCellArray[indexPath.row], userLabel: userDataArray[indexPath.row])
        } else if indexPath.row == 1 {
            cell.fillCell(titleLabel: titleOfCellArray[indexPath.row],
                          userLabel: userDataArray[indexPath.row], googleAuth: googleAuth)
        } else {
            cell.fillCell(titleLabel: titleOfCellArray[indexPath.row])
        }

        return cell
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
