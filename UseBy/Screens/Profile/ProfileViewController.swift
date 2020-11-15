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

    struct UIConstants {
        static let topTableView: CGFloat = 217.0
        static let heightTableView: CGFloat = 240.0
        static let tableToLogout: CGFloat = 30
        static let marginLogoutButtom: CGFloat = 20
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
    
    private let array = ["name".localized, "email".localized, "change-password".localized, "send-feedback".localized]
    private let userArray: [String] = {
        let someModel = SomeModel(name: "Siri", email: "apple@mail.ru")
        return [someModel.name, someModel.email]
    }()
    
    private let logOutButton = MainButton(
        text: "log-out".localized,
        theme: .pseudo
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(UIConstants.topTableView)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(UIConstants.heightTableView)
        }
        view.backgroundColor = Colors.mainBGColor
        configureLogOutButton()
    }

    lazy var composer = MFMailComposeViewController()

    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            _ = Alert(title: "ops".localized,
                  message: "you_don't_have_mail_app_on_your_phone".localized,
                  placeholder1: nil, placeholder2: nil, action: .non)
            return
        }
        composer.mailComposeDelegate = self
        composer.setToRecipients(["use_by@gmail.com"])
        present(composer, animated: true)
    }

    func configureLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).inset(UIConstants.marginLogoutButtom)
            make.centerX.equalTo(view)
            make.top.equalTo(profileTableView.snp.bottom).offset(UIConstants.tableToLogout)
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
            _ = Alert(title: "new-name".localized,
                      message: nil, placeholder1: "put-your-name".localized, action: .save)
        case 1:
            _ = Alert(title: "new-email".localized, message: nil,
                      placeholder1: "input-your-new-email-here".localized, action: .save)
        case 2:
            _ = Alert(title: "new-password".localized, message: nil,
                      placeholder1: "input-your-new-password-here",
                      placeholder2: "confirm-your-new-password".localized, action: .save)
        default:
            showMailComposer()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingsCell",
                                                       for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()//   верни пустую ячейку
        }
        if (indexPath.row==0) || (indexPath.row==1) {
            cell.fillCell(titleLabel: array[indexPath.row], userLabel: userArray[indexPath.row])
        } else {cell.fillCell(titleLabel: array[indexPath.row])
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
