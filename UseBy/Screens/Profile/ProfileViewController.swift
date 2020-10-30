//
//  ProfileViewController.swift
//  UseBy
//
//  Created by Admin on 25.10.2020.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct UIConstants {
        static let topTableView: CGFloat = 217.0
        static let heightTableView: CGFloat = 240.0
        static let tableToLogout: CGFloat = 30
        static let widthToLogout: CGFloat = 20
    }

    lazy var profileTableView: UITableView = { //less place, no data while use
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(UIConstants.topTableView)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(UIConstants.heightTableView)
        }
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "My Cell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()
    private let array = ["name".localized, "email".localized, "change-password".localized, "send-feedback".localized]
    private let userArray: [String] = {
        let someModel = SomeModel(name: "Siri", email: "apple@mail.ru")
        return [someModel.name, someModel.email, "", ""]
    }()
    private let logOutButton = MainButton(
        text: "log-out".localized,
        theme: .pseudo
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBGColor
        configureLogOutButton()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell",
                                                       for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()//   верни пустую ячейку
        }
        cell.fillCell(titleLabel: array[indexPath.row], userLabel: userArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    /*lazy var alert: UIAlertController = {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }()*/
    var alertTitle: String = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            alertTitle = "new-name".localized
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your name here"
            })
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                /*if let name = alert.textFields?.first?.text {
                    print("Your name: \(name)")
                    //someModel.name = name;
                }*/
            }))
            self.present(alert, animated: true)
        } else if indexPath.row == 1 {
            alertTitle = "new-email".localized
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your new email here"
            })
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                /*if let name = alert.textFields?.first?.text {
                    print("Your name: \(name)")
                    //someModel.email = email;
                }*/
            }))
            self.present(alert, animated: true)
        } else if indexPath.row == 2 {
            alertTitle = "new-password".localized
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your new password here"
            })
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Confirm your new password"
            })
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                /*if let name = alert.textFields?.first?.text {
                    print("Your name: \(name)")
                    //someModel.password = password;
                }*/
            }))
            self.present(alert, animated: true)
        } else if indexPath.row == 3 {
            /*let email = "use-up@mail.com"
            if let url = URL(string: "mailto:\(email)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }*/
        }
    }
    func configureLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).inset(UIConstants.widthToLogout)
            make.centerX.equalTo(view)
            make.top.equalTo(profileTableView.snp.bottom).offset(UIConstants.tableToLogout)
        }
    }
}
