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

        expiresLabel.font = Fonts.mainText
        dateLabel.font = Fonts.mainButtonText
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
        static let padding: CGFloat = 15
        static let cornerRadius: CGFloat = 15
    }

    private var label = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(label)
        label.textColor = Colors.secondaryTextColor
        label.font = Fonts.smallHeadlineText

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

class ProductCard: UIView {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let controlsSpacing: CGFloat = 5
    }

    private var nameLabel = UILabel()
    private var expirationLabel = ExpirationDateLabel()
    private var tagLabel = TagLabel()

    init() {
        super.init(frame: .zero)

        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowOpacity = 1.0
        layer.shadowColor = Colors.shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 10

        nameLabel.font = Fonts.mainText

        let labels = [nameLabel, expirationLabel, tagLabel]
        [nameLabel, expirationLabel, tagLabel].forEach {
            self.addSubview($0)
        }

        nameLabel.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self).offset(-UIConstants.padding)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(UIConstants.padding)
        }

        expirationLabel.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self).offset(-UIConstants.padding)
            make.centerX.equalTo(self)
            make.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.controlsSpacing)
        }

        tagLabel.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(self).offset(UIConstants.padding)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-UIConstants.padding)
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductsTableCell: UITableViewCell {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let cardPadding: CGFloat = 40
    }

    private var card = ProductCard()

    func fillCell(product: Product) {
        card.fillCard(product: product)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
