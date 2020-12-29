import Foundation
import UIKit

class FirstScreenView: UIView {
    struct UIConstants {
        static let imageHeight: CGFloat = 250
        static let labelMargin: CGFloat = 10
        static let arrowHeight: CGFloat = 200
        static let arrowWidth: CGFloat = 150
        static let arrowCenterOffset: CGFloat = 50
        static let height: CGFloat = 500
    }

    private let label = UILabel()
    private let image = UIImageView(image: UIImage(named: "FirstOpen"))
    private let arrow = UIImageView(image: UIImage(named: "SelectArrow"))

    init() {
        super.init(frame: .zero)

        self.snp.makeConstraints {(make) in
            make.height.equalTo(UIConstants.height)
        }

        addSubview(image)
        image.snp.makeConstraints {(make) in
            make.width.equalTo(UIConstants.imageHeight)
            make.height.equalTo(UIConstants.imageHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        label.text = "empty-screen".localized
        label.font = Fonts.largeTitleText
        label.textColor = Colors.secondaryTextColor
        label.textAlignment = .center
        addSubview(label)
        label.snp.makeConstraints {(make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(image.snp.bottom).offset(UIConstants.labelMargin)
        }

        addSubview(arrow)
        arrow.snp.makeConstraints {(make) in
            make.width.equalTo(UIConstants.arrowWidth)
            make.height.equalTo(UIConstants.arrowHeight)
            make.centerX.equalTo(self).offset(UIConstants.arrowCenterOffset)
            make.top.equalTo(label.snp.bottom)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
