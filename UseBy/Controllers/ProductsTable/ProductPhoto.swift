import Foundation
import UIKit

class ProductPhoto: UIView {
    struct UIConstants {
        static let width: CGFloat = 125
        static let emptyPhotoWidth: CGFloat = 55
    }
    private var imageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
    }

    func setPhoto(photoUrl: String) {
        // TODO: получение картинки из урла
    }

    func setEmptyPhotoIcon() {
        imageView.image = UIImage(named: "PhotoIcon")
        imageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.emptyPhotoWidth)
            make.width.equalTo(UIConstants.emptyPhotoWidth)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
