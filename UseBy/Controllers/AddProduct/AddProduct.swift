//
//  AddProduct.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/21/20.
//

import Foundation
import UIKit

class AddProductViewController: UIViewController {
    struct UIConstants {
        static let buttonPadding: CGFloat = 40
        static let buttonBottomMargin: CGFloat = 40
        static let closeIconMargin: CGFloat = 20
    }

    private let addButton = MainButton(
        text: "add".localized,
        theme: .normal
    )
    private let closeIcon = IconView(
        name: "CloseIcon",
        size: .large
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureAddButton()
        configureCloseIcon()
    }

    func configureAddButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(-UIConstants.buttonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-UIConstants.buttonBottomMargin)
        }
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    func configureCloseIcon() {
        view.addSubview(closeIcon)
        closeIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.closeIconMargin)
            make.right.equalTo(view).offset(-UIConstants.closeIconMargin)
        }
        closeIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseIcon)))
    }

    @objc
    func didTapAddButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
