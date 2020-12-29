import Foundation
import UIKit

class NothingFoundView: UIView {
    struct UIConstants {
        static let imageHeight: CGFloat = 250
        static let labelMargin: CGFloat = 10
        static let arrowHeight: CGFloat = 200
        static let arrowWidth: CGFloat = 150
        static let arrowCenterOffset: CGFloat = 50
        static let height: CGFloat = 500
    }

    private let label = UILabel()
    private let image = UIImageView(image: UIImage(named: "NotFound"))

    init() {
        super.init(frame: .zero)

        self.snp.makeConstraints {(make) in
            make.height.equalTo(UIConstants.height)
        }

        addSubview(image)
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints {(make) in
            make.width.equalTo(UIConstants.imageHeight)
            make.height.equalTo(UIConstants.imageHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        label.text = "filters-empty".localized
        label.font = Fonts.largeTitleText
        label.textColor = Colors.secondaryTextColor
        label.textAlignment = .center
        addSubview(label)
        label.snp.makeConstraints {(make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(image.snp.bottom).offset(UIConstants.labelMargin)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
