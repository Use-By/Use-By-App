import Foundation
import UIKit

protocol ChangeFiltersViewControllerDelegate: AnyObject {
    func applyFilters(filters: ProductFilters)
}

class ChangeFiltersViewController: UIViewController {
    struct UIConstants {
        static let buttonsSpacing: CGFloat = 20
        static let buttonBottomMargin: CGFloat = 40
        static let buttonPadding: CGFloat = 20
        static let titleMargin: CGFloat = 20
        static let fieldsSpacing: CGFloat = 10
        static let padding: CGFloat = 40
    }

    private let titleLabel = MainScreenTitle(labelType: .filterBy)
    private let orderTitleLabel = MainScreenTitle(labelType: .orderBy)
    private let applyButton = MainButton(
        text: "apply".localized,
        theme: .normal
    )
    private let resetButton = MainButton(
        text: "reset".localized,
        theme: .pseudo
    )
    private let closeIcon = IconView(
        name: "CloseIcon",
        size: .large
    )
    private let orderFields = [
        ValueFieldWithCheckbox(name: "expiry-desc".localized),
        ValueFieldWithCheckbox(name: "expiry-asc".localized)
    ]

    private var filters: ProductFilters
    weak var delegate: ChangeFiltersViewControllerDelegate?

    init(filters: ProductFilters) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        configureButtons()
        configureCloseIcon()
        configureFilterFields()
        configureOrderFields()
    }

    func configureOrderFields() {
        view.addSubview(orderTitleLabel)
        orderTitleLabel.snp.makeConstraints {(make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.fieldsSpacing)
            make.left.equalTo(view).offset(UIConstants.titleMargin)
        }
        orderFields.forEach {
            view.addSubview($0)
        }

        orderFields[0].snp.makeConstraints { (make) in
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.centerX.equalTo(view)
            make.top.equalTo(orderTitleLabel.snp.bottom)
        }

        orderFields[1].snp.makeConstraints { (make) in
            make.width.equalTo(view).offset(-UIConstants.padding)
            make.centerX.equalTo(view)
            make.top.equalTo(orderFields[0].snp.bottom)
        }

        setOrderValue()
    }

    func setOrderValue() {
        switch filters.sort {
        case .asc:
            orderFields[0].isChecked = false
            orderFields[1].isChecked = true
        case .desc:
            orderFields[0].isChecked = true
            orderFields[1].isChecked = false
        default:
            orderFields[0].isChecked = false
            orderFields[1].isChecked = false
        }
    }

    func configureCloseIcon() {
        view.addSubview(closeIcon)
        closeIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.titleMargin)
            make.right.equalTo(view).offset(-UIConstants.titleMargin)
        }
        closeIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseIcon)))
    }

    func configureButtons() {
        let arrangedSubviews = [resetButton, applyButton]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .horizontal
        stackviewFields.spacing = UIConstants.buttonsSpacing
        stackviewFields.distribution = .fillEqually
        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.bottom.equalTo(view).offset(-UIConstants.buttonBottomMargin)
            make.left.equalTo(view).offset(UIConstants.buttonPadding)
            make.right.equalTo(view).offset(-UIConstants.buttonPadding)
        }

        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
    }

    func configureFilterFields() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIConstants.titleMargin)
            make.left.equalTo(view).offset(UIConstants.titleMargin)
        }
    }

    @objc
    func didTapResetButton() {
        self.delegate?.applyFilters(
            filters: ProductFilters(searchByName: nil, isLiked: false, isExpired: false, tag: nil, sort: nil)
        )
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapApplyButton() {
        self.delegate?.applyFilters(filters: filters)
        dismiss(animated: true, completion: nil)
    }

    @objc
    func didTapCloseIcon() {
        dismiss(animated: true, completion: nil)
    }
}
