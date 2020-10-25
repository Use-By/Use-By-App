//
//  ProfileViewController.swift
//  UseBy
//
//  Created by Admin on 25.10.2020.
//

import Foundation
import UIKit
import SnapKit

struct SomeModel { // why
    static let name = "name".localized //const
    static let email = "email".localized
    static let changepass = "change-password".localized
    static let feedback = "send-feedback".localized
}

class ProfileTableCell: UITableViewCell { // mycell
    private var valueLabel: UILabel = {
        let label = UILabel() // emty label
        label.font = Fonts.mainText
        label.textColor = Colors.secondaryTextColor
        return label
    }()
    
    func fillCell(titleLabel: String, value: String) {
        self.textLabel?.text = titleLabel
        self.valueLabel.text = value
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = Fonts.mainText
        self.accessoryType = .disclosureIndicator
        self.addSubview(valueLabel)//итак находимся во вью
        valueLabel.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-40)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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

        self.view.addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(UIConstants.topTableView)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(UIConstants.heightTableView)
        }
        tableView.dataSource = self

        tableView.register(MyCell.self, forCellReuseIdentifier: identifire)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()
    func createTable (tableView: UITableView) {
        tableView.register(MyCell.self, forCellReuseIdentifier: identifire)
        tableView.delegate = self
    }
    var array = ["name".localized, "email".localized, "change-password".localized, "send-feedback".localized]// dont need

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBGColor
        configureLogOutButton()
        //profileTableView()
        createTable(tableView: profileTableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4

    }
    let identifire = "MyCell"

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifire,
                                                       for: indexPath) as? MyCell else {
            return UITableViewCell()}//   верни пустую ячейку
        let titleLabel = array[indexPath.row] // how refuse
        cell.fillCell(titleLabel: titleLabel, value: "siri")

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    private let logOutButton = MainButton(
        text: "log-out".localized,
        theme: .pseudo
    )
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
