import Foundation
import UIKit
import Kingfisher

class ProductPhoto: UIView {
    struct UIConstants {
        static let width: CGFloat = 125
        static let emptyPhotoWidth: CGFloat = 55
        static let cornerRadius: CGFloat = 10
    }
    private var imageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self)
        }
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }

    func setPhoto(photoUrl: String) {
        guard let url = URL(string: photoUrl) else {
            return
        }
        imageView.kf.setImage(with: url)
        imageView.snp.remakeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self)
        }
    }

    func setEmptyPhotoIcon() {
        imageView.image = UIImage(named: "PhotoIcon")
        imageView.snp.remakeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.height.equalTo(UIConstants.emptyPhotoWidth)
            make.width.equalTo(UIConstants.emptyPhotoWidth)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .bottomLeft], radius: UIConstants.cornerRadius)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
