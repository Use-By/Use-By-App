import Foundation
import UIKit
import SnapKit

class MainScreenViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = Colors.mainActionColor

        let productsVC = Router(rootViewController: ProductsViewController())
        productsVC.tabBarItem.title = "home".localized
        productsVC.tabBarItem.image = UIImage(named: "HomeIcon")

        let profileVC = ProfileViewController()
        profileVC.tabBarItem.title = "profile".localized
        profileVC.tabBarItem.image = UIImage(named: "ProfileIcon")

        viewControllers = [productsVC, profileVC]
        configureAddButton()
    }

    func configureAddButton() {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var addButtonFrame = addButton.frame
        addButtonFrame.origin.y = view.bounds.height - addButtonFrame.height - 50
        addButtonFrame.origin.x = view.bounds.width/2 - addButtonFrame.size.width/2
        addButton.frame = addButtonFrame

        addButton.backgroundColor = Colors.mainActionColor
        addButton.layer.cornerRadius = addButtonFrame.height/2
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = Colors.actionIconShadowColor.cgColor
        addButton.adjustsImageWhenHighlighted = false
        view.addSubview(addButton)

        addButton.setImage(UIImage(named: "PlusIcon"), for: .normal)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)

        view.layoutIfNeeded()
    }

    @objc
    func didTapAddButton() {
        let addProductVC = AddProductViewController()
        present(addProductVC, animated: true, completion: nil)
    }
}
