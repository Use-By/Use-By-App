import Foundation
import UIKit

protocol ProductsTableCellDelegate: AnyObject {
    func didTapDeleteButton()
    func didTapLikeButton()
}

class ProductCard: UIView {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let sidePadding: CGFloat = 5
        static let controlsSpacing: CGFloat = 20
        static let imageWidth: CGFloat = 125
    }

    private var deleteIcon = IconButton(name: "DeleteIcon", size: .medium, theme: .secondary)
    private var likeIcon = IconButton(name: "LikeLineIcon", size: .medium, theme: .action)
    private let nameLabel = UILabel()
    private let expirationLabel = ExpirationDateLabel()
    private let tagLabel = TagLabel()
    private let productPhoto = ProductPhoto()

    private var product: Product?
    weak var delegate: ProductsTableCellDelegate?

    init() {
        super.init(frame: .zero)

        backgroundColor = Colors.mainBGColor
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowColor = Colors.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 5
        isUserInteractionEnabled = true

        addSubview(deleteIcon)
        addSubview(likeIcon)

        deleteIcon.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-UIConstants.sidePadding)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
        }
        deleteIcon.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)

        likeIcon.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(-UIConstants.sidePadding)
            make.top.equalTo(self).offset(UIConstants.padding)
        }
        likeIcon.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)

        configurePhoto()
        configureLabels()
    }

    func configurePhoto() {
        addSubview(productPhoto)
        productPhoto.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self)
            make.width.equalTo(UIConstants.imageWidth)
            make.height.equalTo(self)
        }
    }

    func configureLabels() {
        nameLabel.font = Fonts.cardText
        [nameLabel, expirationLabel, tagLabel].forEach {
            self.addSubview($0)
        }

        nameLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.top.equalTo(self).offset(UIConstants.padding)
        }

        expirationLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.controlsSpacing)
        }

        tagLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(productPhoto.snp.right).offset(UIConstants.sidePadding)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
        }
    }

    func fillCard(product: Product) {
        self.product = product
        nameLabel.text = product.name

        if let tag = product.tag {
            tagLabel.setText(text: tag)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        expirationLabel.setDate(date: dateFormatter.string(from: product.expirationDate))

        if let photoUrl = product.photoUrl {
            productPhoto.setPhoto(photoUrl: photoUrl)
        } else {
            productPhoto.setEmptyPhotoIcon()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func didTapLikeButton() {
        self.delegate?.didTapLikeButton()
    }

    @objc
    func didTapDeleteButton() {
        self.delegate?.didTapDeleteButton()
    }
}

class ProductsTableCell: UITableViewCell, ProductsTableCellDelegate {
    struct UIConstants {
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let cardPadding: CGFloat = 40
    }

    private var card = ProductCard()
    weak var delegate: ProductsTableCellDelegate?

    func fillCell(product: Product) {
        card.fillCard(product: product)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        isUserInteractionEnabled = true
        selectionStyle = .none

        contentView.addSubview(card)
        card.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self).offset(-UIConstants.cardPadding)
            make.center.equalTo(self)
            make.height.equalTo(self).offset(-UIConstants.padding)
        }

        card.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didTapDeleteButton() {
        self.delegate?.didTapDeleteButton()
    }

    func didTapLikeButton() {
        self.delegate?.didTapLikeButton()
    }
}
