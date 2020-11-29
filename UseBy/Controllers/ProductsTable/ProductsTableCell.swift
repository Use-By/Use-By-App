import Foundation
import UIKit

class ExpirationDateLabel: UIView {
    struct UIConstants {
        static let buttonsOffset: CGFloat = 5
    }

    private var expiresLabel = UILabel()
    private var dateLabel = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(expiresLabel)
        addSubview(dateLabel)

        expiresLabel.font = Fonts.cardText
        dateLabel.font = Fonts.cardBoldText
        expiresLabel.text = "expires".localized

        expiresLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }

        dateLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(expiresLabel.snp.right).offset(UIConstants.buttonsOffset)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDate(date: String) {
        dateLabel.text = date
    }
}

class TagLabel: UIView {
    struct UIConstants {
        static let padding: CGFloat = 25
        static let cornerRadius: CGFloat = 13
        static let height: CGFloat = 25
    }

    private var label = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(label)
        label.textColor = Colors.secondaryTextColor
        label.font = Fonts.smallHeadlineText

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.height)
        }

        layer.cornerRadius = UIConstants.cornerRadius
        layer.borderWidth = 1
        layer.borderColor = Colors.secondaryTextColor.cgColor

        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.width.equalTo(self).offset(-UIConstants.padding)
        }
    }

    func setText(text: String) {
        label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductPhoto: UIView {
    struct UIConstants {
        static let width: CGFloat = 125
    }
    private var imageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
    }

    func setPhoto() {

    }

    func setEmptyPhotoIcon() {
        imageView.image = UIImage(named: "PhotoIcon")
        imageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
            make.width.equalTo(55)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductCard: UIView {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let controlsSpacing: CGFloat = 20
        static let imageWidth: CGFloat = 125
    }

    private var nameLabel = UILabel()
    private var expirationLabel = ExpirationDateLabel()
    private var tagLabel = TagLabel()
    private var deleteIcon = IconView(name: "DeleteIcon", size: .medium, theme: .secondary)
    private var likeIcon = IconView(name: "LikeLineIcon", size: .medium, theme: .action)
    private let productPhoto = ProductPhoto()

    init() {
        super.init(frame: .zero)

        backgroundColor = Colors.mainBGColor
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowColor = Colors.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 5

        addSubview(productPhoto)
        productPhoto.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self)
            make.width.equalTo(UIConstants.imageWidth)
            make.height.equalTo(self)
        }

        nameLabel.font = Fonts.cardText

        [nameLabel, expirationLabel, tagLabel].forEach {
            self.addSubview($0)
        }

        nameLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.padding / 2)
            make.top.equalTo(self).offset(UIConstants.padding)
        }

        expirationLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.padding / 2)
            make.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.controlsSpacing)
        }

        tagLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.padding / 2)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
        }

        addSubview(deleteIcon)
        addSubview(likeIcon)

        deleteIcon.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-UIConstants.padding / 2)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
        }
        likeIcon.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-UIConstants.padding / 2)
            make.top.equalTo(self).offset(UIConstants.padding)
        }
    }

    func fillCard(product: Product) {
        nameLabel.text = product.name

        if let tag = product.tag {
            tagLabel.setText(text: tag)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        expirationLabel.setDate(date: dateFormatter.string(from: product.expirationDate))

        if product.photoUrl == nil {
            productPhoto.setEmptyPhotoIcon()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductsTableCell: UITableViewCell {
    struct UIConstants {
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let cardPadding: CGFloat = 40
    }

    private var card = ProductCard()

    func fillCell(product: Product) {
        card.fillCard(product: product)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        addSubview(card)
        card.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self).offset(-UIConstants.cardPadding)
            make.center.equalTo(self)
            make.height.equalTo(self).offset(-UIConstants.padding)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
