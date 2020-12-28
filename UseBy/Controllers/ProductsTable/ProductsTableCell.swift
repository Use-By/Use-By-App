import Foundation
import UIKit

protocol ProductsTableCellDelegate: AnyObject {
    func didTapDeleteButton(id: String)
    func didTapLikeButton(id: String, liked: Bool)
}

class ProductCardShadow: UIView {
    struct UIConstants {
        static let shadowRadius: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let shadowOpacity: Float = 1.0
    }

    init() {
        super.init(frame: .zero)

        backgroundColor = Colors.mainBGColor
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowOpacity = UIConstants.shadowOpacity
        layer.masksToBounds = false
        layer.shadowColor = Colors.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = UIConstants.shadowRadius
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
        static let sidePadding: CGFloat = 5
        static let iconPadding: CGFloat = 25
        static let controlsSpacing: CGFloat = 20
        static let imageWidth: CGFloat = 145
    }

    private var deleteIcon = IconButton(name: "DeleteIcon", size: .medium, theme: .secondary)
    private var likeIcon = IconButton(name: "LikeLineIcon", size: .medium, theme: .action)
    private let expirationLabel = ExpirationDateLabel()
    private let tagLabel = TagLabel()
    private let productPhoto = ProductPhoto()
    private let cardShadow = ProductCardShadow()

    weak var delegate: ProductsTableCellDelegate?
    private var product: Product?

    func setLikeIcon(isLiked: Bool) {
        if isLiked {
            likeIcon.setNewIcon(name: "LikeIcon", size: .medium, theme: .action)
        } else {
            likeIcon.setNewIcon(name: "LikeLineIcon", size: .medium, theme: .action)
        }
    }

    func fillCell(product: Product) {
        self.product = product
        textLabel?.text = product.name

        if let tag = product.tag, tag.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            tagLabel.setText(text: tag)
            tagLabel.isHidden = false
        } else {
            tagLabel.isHidden = true
        }

        if let expirationDate = product.expirationDate {
            expirationLabel.isHidden = false
            expirationLabel.setDate(date: expirationDate)
        } else {
            expirationLabel.isHidden = true
        }

        if let photoUrl = product.photoUrl {
             productPhoto.setPhoto(photoUrl: photoUrl)
        } else {
            productPhoto.setEmptyPhotoIcon()
        }

        setLikeIcon(isLiked: product.isLiked)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        isUserInteractionEnabled = true
        selectionStyle = .none

        contentView.addSubview(cardShadow)
        cardShadow.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self).offset(-UIConstants.cardPadding)
            make.center.equalTo(self)
            make.height.equalTo(self).offset(-UIConstants.padding)
        }

        configurePhoto()
        configureIcons()
        configureLabels()
    }

    func configureIcons() {
        addSubview(likeIcon)
        likeIcon.snp.makeConstraints {(make) -> Void in
                    make.right.equalTo(self).offset(-UIConstants.iconPadding)
                    make.top.equalTo(self).offset(UIConstants.padding)
        }
        likeIcon.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)

        addSubview(deleteIcon)
        deleteIcon.snp.makeConstraints {(make) -> Void in
                    make.right.equalTo(self).offset(-UIConstants.iconPadding)
                    make.bottom.equalTo(self).offset(-UIConstants.padding)
        }
        deleteIcon.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }

    func configurePhoto() {
        addSubview(productPhoto)
        productPhoto.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self).offset(UIConstants.controlsSpacing)
            make.width.equalTo(UIConstants.imageWidth)
            make.top.equalTo(self).offset(UIConstants.padding/2)
            make.bottom.equalTo(self).offset(-UIConstants.padding/2)
        }
    }

    func configureLabels() {
        guard let textLabel = textLabel else {
            return
        }

        textLabel.font = Fonts.cardText
        textLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.top.equalTo(self).offset(UIConstants.padding)
            make.right.equalTo(likeIcon.snp.left)
        }
        textLabel.numberOfLines = 1
        textLabel.lineBreakMode = .byTruncatingTail

        addSubview(expirationLabel)
        expirationLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.top.equalTo(textLabel.snp.bottom).offset(UIConstants.controlsSpacing)
        }

        addSubview(tagLabel)
        tagLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func didTapLikeButton() {
        self.delegate?.didTapLikeButton(id: self.product?.id ?? "",
                                        liked: !(self.product?.isLiked ?? false))
    }

    @objc
    func didTapDeleteButton() {
        self.delegate?.didTapDeleteButton(id: self.product?.id ?? "")
    }
}
