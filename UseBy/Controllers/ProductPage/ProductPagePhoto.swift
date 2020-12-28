import Foundation
import UIKit
import Kingfisher

class ProductPagePhoto: UIView {
    struct UIConstants {
        static let width: CGFloat = 125
        static let emptyPhotoWidth: CGFloat = 65
        static let cornerRadius: CGFloat = 14
        static let labelMargin: CGFloat = 10
    }
    var imageView = UIImageView()
    private var emptyImageView = UIImageView()
    private var emptyLabel = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self)
        }
        imageView.contentMode = .scaleAspectFill

        addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints {(make) in
            make.center.equalTo(self)
            make.height.equalTo(UIConstants.emptyPhotoWidth)
            make.width.equalTo(UIConstants.emptyPhotoWidth)
        }

        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {(make) in
            make.top.equalTo(emptyImageView.snp.bottom).offset(UIConstants.labelMargin)
            make.centerX.equalTo(self)
        }
        emptyLabel.font = Fonts.largeTitleText
        emptyLabel.textColor = Colors.mainActionColor
        emptyLabel.isHidden = true
        emptyLabel.text = "add-photo".localized

        clipsToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        isUserInteractionEnabled = true
    }

    func setPhoto(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        imageView.kf.setImage(with: url)
        emptyLabel.isHidden = true
        emptyImageView.isHidden = true
        imageView.isHidden = false
    }

    func setPhoto(with data: Data) {
        imageView.image = UIImage(data: data)
        emptyLabel.isHidden = true
        emptyImageView.isHidden = true
        imageView.isHidden = false
    }

    func setPhoto(with image: UIImage) {
        imageView.image = image
        emptyLabel.isHidden = true
        emptyImageView.isHidden = true
        imageView.isHidden = false
    }

    func setEmptyPhotoIcon() {
        if emptyImageView.image == nil {
            emptyImageView.image = UIImage(named: "AddPhoto")
        }
        emptyImageView.isHidden = false
        imageView.image = nil
        imageView.isHidden = true
        emptyLabel.isHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
