import Foundation
import UIKit

class FilterButton: UIButton {
    struct UIConstants {
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat = 10
        static let iconMargin: CGFloat = 5
        static let innerMargin: CGFloat = 10
    }

    var icon: Icon?

    init(text: String, icon: Icon? = nil) {
        self.icon = icon
        super.init(frame: .zero)

        adjustsImageWhenHighlighted = false
        titleLabel?.text = text
        setTitle(text, for: .normal)
        titleLabel?.font = Fonts.mainText
        titleLabel?.textAlignment = .center
        layer.cornerRadius = UIConstants.cornerRadius

        backgroundColor = Colors.filterControlBackground
        setTitleColor(Colors.filterHighlightColor, for: .normal)
        setTitleColor(Colors.inversedTextColor, for: .highlighted)
        self.contentEdgeInsets = UIEdgeInsets(
            top: UIConstants.innerMargin,
            left: UIConstants.innerMargin,
            bottom: UIConstants.innerMargin,
            right: UIConstants.innerMargin
        )

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
        }

        if let icon = icon {
            setImage(icon.icon, for: .normal)
            let tintedImage = icon.icon?.withTintColor(Colors.inversedTextColor)
            setImage(tintedImage, for: .highlighted)
            titleEdgeInsets.left = UIConstants.iconMargin
            titleEdgeInsets.right = -UIConstants.iconMargin
            contentEdgeInsets.right += UIConstants.iconMargin
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isActive {
                return
            }

            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: [.beginFromCurrentState, .transitionCrossDissolve, .curveEaseInOut],
                animations: {
                    self.backgroundColor = self.isHighlighted
                        ? Colors.filterHighlightColor
                        : Colors.filterControlBackground
                }, completion: nil)
        }
    }

    var isActive: Bool = false {
        didSet {
            if isActive {
                self.backgroundColor = Colors.filterHighlightColor
                setTitleColor(Colors.inversedTextColor, for: .normal)

                if let icon = self.icon {
                    let tintedImage = icon.icon?.withTintColor(Colors.inversedTextColor)
                    setImage(tintedImage, for: .normal)
                }
            } else {
                self.backgroundColor = Colors.filterControlBackground
                setTitleColor(Colors.filterHighlightColor, for: .normal)

                if let icon = self.icon {
                    setImage(icon.icon, for: .normal)
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
