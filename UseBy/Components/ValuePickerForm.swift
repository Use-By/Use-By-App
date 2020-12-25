import Foundation
import UIKit

protocol ValuePickerFormDelegate: AnyObject {
    func getData() -> [String]
    func applyData(value: String?)
}

protocol DateValuePickerFormDelegate: AnyObject {
    func valuePickerApplied(_ valuePicker: DateValuePickerForm, value: Date?)
}

protocol DateValuePickerFormModalDelegate: AnyObject {
    func valuePickerApplied(value: Date?)
}

class ValuePickerFormModal: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let dividerHeight: CGFloat = 1
        static let height: CGFloat = 300
        static let pickerHeight: CGFloat = 250
    }

    private let picker = UIPickerView()
    private let toolbar = { () -> UIToolbar in
        let toolbar = UIToolbar(frame: .zero)
        toolbar.tintColor = Colors.secondaryTextColor

        let applyButton = UIBarButtonItem(
            title: "apply".localized,
            style: .plain,
            target: self,
            action: #selector(didTapApplyButton)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(
            title: "cancel".localized,
            style: .plain,
            target: self,
            action: #selector(didTapCancelIcon)
        )

        toolbar.setItems([cancelButton, flexSpace, applyButton], animated: true)

        return toolbar
    }()

    private var value: String?
    weak var delegate: ValuePickerFormDelegate?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let data = delegate?.getData() {
            return data.count
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        value = delegate?.getData()[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let data = delegate?.getData() {
            return data[row]
        }

        return ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        picker.snp.makeConstraints {(make) in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(UIConstants.pickerHeight)
        }
        picker.delegate = self

        view.addSubview(toolbar)
        toolbar.snp.makeConstraints {(make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }
        toolbar.tintColor = Colors.secondaryTextColor
        let applyButton = UIBarButtonItem(
            title: "apply".localized,
            style: .plain,
            target: self,
            action: #selector(didTapApplyButton)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(
            title: "cancel".localized,
            style: .plain,
            target: self,
            action: #selector(didTapCancelIcon)
        )

        toolbar.setItems([cancelButton, flexSpace, applyButton], animated: true)
    }

    @objc
    func didTapApplyButton() {
        dismiss(animated: true, completion: nil)
        delegate?.applyData(value: value)
    }

    @objc
    func didTapCancelIcon() {
        dismiss(animated: true, completion: nil)
        delegate?.applyData(value: nil)
    }

}

class DateValuePickerFormModal: UIViewController {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let dividerHeight: CGFloat = 1
        static let height: CGFloat = 300
        static let pickerHeight: CGFloat = 250
    }

    private let picker = { () -> UIDatePicker in
        let picker = UIDatePicker()
        picker.datePickerMode = .date

        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }

        return picker
    }()
    private let toolbar = { () -> UIToolbar in
        let toolbar = UIToolbar(frame: .zero)
        toolbar.tintColor = Colors.secondaryTextColor

        let applyButton = UIBarButtonItem(
            title: "apply".localized,
            style: .plain,
            target: self,
            action: #selector(didTapApplyButton)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(
            title: "cancel".localized,
            style: .plain,
            target: self,
            action: #selector(didTapCancelIcon)
        )

        toolbar.setItems([cancelButton, flexSpace, applyButton], animated: true)

        return toolbar
    }()
    private var date: Date?

    weak var delegate: DateValuePickerFormModalDelegate?

    init(date: Date?) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        view.addSubview(picker)
        picker.snp.makeConstraints {(make) in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(UIConstants.pickerHeight)
        }

        if let date = date {
            picker.setDate(date, animated: true)
        }

        view.addSubview(toolbar)
        toolbar.snp.makeConstraints {(make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }
    }

    @objc
    func didTapApplyButton() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: picker.date)
    }

    @objc
    func didTapCancelIcon() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: nil)
    }
}

class DateValuePickerForm: UIViewController, DateValuePickerFormModalDelegate {
    struct UIConstants {
        static let height: CGFloat = 60
        static let dividerHeight: CGFloat = 1
        static let iconMargin: CGFloat = 5
    }

    let nameLabel = UILabel()
    let valueLabel = UILabel()
    let arrowIcon = IconView(name: "RightArrow", size: .small, theme: .secondary)
    var valuePlaceholder: String = ""
    var tag: Int = 0
    var value: Date?
    weak var delegate: DateValuePickerFormDelegate?

    init(name: String, placeholder: String = "") {
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = name
        valuePlaceholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.snp.makeConstraints { (make) in
            make.height.equalTo(UIConstants.height)
        }

        view.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(view)
            make.centerY.equalTo(view)
        }

        configureNameLabel()
        configureValueLabel()
        configureDivider()

        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEdit)))
    }

    func configureNameLabel() {
        nameLabel.textColor = Colors.mainTextColor
        nameLabel.font = Fonts.mainText
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.centerY.equalTo(view)
        }
    }

    func configureValueLabel() {
        valueLabel.textColor = Colors.secondaryTextColor
        valueLabel.font = Fonts.mainText
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(arrowIcon.snp.left).offset(-UIConstants.iconMargin)
            make.centerY.equalTo(view)
        }
    }

    func configureDivider() {
        let divider: UIView = UIView()
        divider.backgroundColor = Colors.inputDividerColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)

        divider.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(UIConstants.dividerHeight)
            make.width.equalTo(view)
            make.bottom.equalTo(view).offset(-UIConstants.dividerHeight)
        }
    }

    func setValue(value: Date?) {
        self.value = value
        if let value = value {
            let calendar = Calendar.current

            if calendar.isDateInToday(value) {
                valueLabel.text = "today".localized

                return
            }

            if calendar.isDateInTomorrow(value) {
                valueLabel.text = "tomorrow".localized

                return
            }

            if calendar.isDateInYesterday(value) {
                valueLabel.text = "yesterday".localized

                return
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            valueLabel.text = dateFormatter.string(from: value)
        } else {
            valueLabel.text = valuePlaceholder
        }
    }

    @objc
    func didTapEdit() {
        let picker = DateValuePickerFormModal(date: value)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func valuePickerApplied(value: Date?) {
        delegate?.valuePickerApplied(self, value: value)
        setValue(value: value)
    }
}
