//
//  ProfileViewController.swift
//  UseBy
//
//  Created by Admin on 25.10.2020.
//

import Foundation
import UIKit
import SnapKit

struct SomeModel { //     явное имя данные пользователя
    let name = "Siri"
    let email = "siri@mail.ru"
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct UIConstants {
        static let topTableView: CGFloat = 217.0
        static let heightTableView: CGFloat = 240.0
        static let tableToLogout: CGFloat = 30
        static let widthToLogout: CGFloat = 20
    }

    lazy var profileTableView: UITableView = { //зачем в отдельную переменную -less place, no data while use
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
    let someModel = SomeModel()
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
            return UITableViewCell()
        }//   верни пустую ячейку

        cell.fillCell(titleLabel: array[indexPath.row], with: someModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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
