import Foundation
import UIKit

class FiltersSearch: UISearchBar {
    struct UIConstants {
        static let height: CGFloat = 35
    }

    init() {
        super.init(frame: .zero)

        searchBarStyle = .minimal
        placeholder = "search".localized
        searchTextField.font = Fonts.mainText
        searchTextField.textColor = Colors.secondaryTextColor

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
        }

        searchTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
