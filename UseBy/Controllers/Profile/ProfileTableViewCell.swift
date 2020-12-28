//
//  ProfileTableViewCell.swift
//  UseBy
//
//  Created by Admin on 26.10.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    struct UIConstants {
        static let rightMarginValueLabel: CGFloat = 40.0
    }
    private var valueLabel = TableLable()

    func fillCell(titleLabel: String, userLabel: String? = nil, googleAuth: Bool?=nil) {
        self.textLabel?.text = titleLabel
        self.valueLabel.text = userLabel
        if googleAuth != true {
            self.accessoryType = .disclosureIndicator}

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = Fonts.mainText
        addSubview(valueLabel)

        valueLabel.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-UIConstants.rightMarginValueLabel)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
