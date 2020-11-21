import Foundation
import UIKit
import SnapKit

class TabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        let mainScreenVC = Router(rootViewController: MainScreenViewController())
//        mainScreenVC.tabBarItem.title = "home".localized
//        mainScreenVC.tabBarItem.image = UIImage(named: "HomeIcon")
//
        let profileVC = ProfileViewController()
//        profileVC.tabBarItem.title = "profile".localized
//        profileVC.tabBarItem.image = UIImage(named: "ProfileIcon")
//
        viewControllers = [mainScreenVC, profileVC]
    }
}
