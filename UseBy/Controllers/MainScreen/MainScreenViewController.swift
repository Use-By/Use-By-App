import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    private let emptyScreenLabel = UILabel()
    let tabBar = TabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureTabBar()
    }

    func configureTabBar() {
        view.addSubview(tabBar.view)
        addChild(tabBar)
        tabBar.didMove(toParent: self)
    }
}
