//
//  ProfileTableViewCell.swift
//  UseBy
//
//  Created by Admin on 26.10.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    private var valueLabel: UILabel = {
        let label = UILabel() // emty label 
        label.font = Fonts.mainText
        label.textColor = Colors.secondaryTextColor
        return label
    }()

    func fillCell(titleLabel: String, userLabel: String) {
        self.textLabel?.text = titleLabel
        self.valueLabel.text = userLabel
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

    override func awakeFromNib() { //init
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
