import Foundation
import UIKit

protocol DateValuePickerFieldDelegate: AnyObject {
    func valuePickerApplied(_ valuePicker: DateValuePickerField, value: Date?)
}

protocol DateValuePickerFieldModalDelegate: AnyObject {
    func valuePickerApplied(value: Date?)
}

class DateValuePickerFieldModal: UIViewController {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let fieldsPadding: CGFloat = 40
        static let dividerHeight: CGFloat = 1
        static let height: CGFloat = 300
        static let pickerHeight: CGFloat = 250
    }

    private let notSelected: ValueFieldWithCheckbox
    private let dateSelected: ValueFieldWithCheckbox
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
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }()
    private var dateValue: Date?

    weak var delegate: DateValuePickerFieldModalDelegate?

    init(date: Date?, notSelectedName: String = "not-selected".localized, valueFieldName: String = "select".localized) {
        self.notSelected = ValueFieldWithCheckbox(name: notSelectedName)
        self.dateSelected = ValueFieldWithCheckbox(name: valueFieldName)
        self.dateValue = date
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor

        view.addSubview(toolbar)
        toolbar.snp.makeConstraints {(make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }

        configureFields()
        configureDatePicker()
    }

    func configureFields() {
        view.addSubview(notSelected)
        notSelected.snp.makeConstraints { (make) in
            make.top.equalTo(toolbar.snp.bottom).offset(UIConstants.padding)
            make.width.equalTo(view).offset(-UIConstants.fieldsPadding)
            make.centerX.equalTo(view)
        }

        view.addSubview(dateSelected)
        dateSelected.snp.makeConstraints { (make) in
            make.top.equalTo(notSelected.snp.bottom)
            make.width.equalTo(view).offset(-UIConstants.fieldsPadding)
            make.centerX.equalTo(view)
        }

        notSelected.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNotSelectField)))
        dateSelected.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSelectField)))

        setFieldsValue(value: dateValue)
    }

    func setFieldsValue(value: Date?) {
        switch value {
        case nil:
            notSelected.isChecked = true
            dateSelected.isChecked = false
            picker.isHidden = true
        default:
            notSelected.isChecked = false
            dateSelected.isChecked = true
            picker.isHidden = false
        }
    }

    func configureDatePicker() {
        view.addSubview(picker)
        picker.snp.makeConstraints {(make) in
            make.top.equalTo(dateSelected.snp.bottom).offset(UIConstants.padding)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(UIConstants.pickerHeight)
        }

        if let date = dateValue {
            picker.setDate(date, animated: true)
        }
    }

    @objc
    func didTapSelectField() {
        setFieldsValue(value: picker.date)
    }

    @objc
    func didTapNotSelectField() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: nil)
    }

    @objc
    func didTapApplyButton() {
        dismiss(animated: true, completion: nil)
        let value = notSelected.isChecked ? nil : picker.date
        delegate?.valuePickerApplied(value: value)
    }

    @objc
    func didTapCancelIcon() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: self.dateValue)
    }
}

class DateValuePickerField: UIViewController, DateValuePickerFieldModalDelegate {
    struct UIConstants {
        static let height: CGFloat = 60
        static let dividerHeight: CGFloat = 1
        static let iconMargin: CGFloat = 5
    }

    let valueField: ValueField
    let valueFieldName: String
    var valuePlaceholder: String = ""
    let notSelectedName: String
    var tag: Int = 0
    var formValue: Date?

    init(name: String, placeholder: String = "", notSelectedName: String = "not-selected".localized, valueFieldName: String = "select".localized) {
        valueField = ValueField(name: name)
        self.valueFieldName = name
        self.notSelectedName = notSelectedName
        super.init(nibName: nil, bundle: nil)
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

        view.addSubview(valueField)
        valueField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(view)
            make.width.equalTo(view)
            make.center.equalTo(view)
        }

        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEdit)))
    }

    func setValue(value: Date?) {
        self.formValue = value
        if let value = value {
            let calendar = Calendar.current

            if calendar.isDateInToday(value) {
                valueField.valueLabel.text = "today".localized

                return
            }

            if calendar.isDateInTomorrow(value) {
                valueField.valueLabel.text = "tomorrow".localized

                return
            }

            if calendar.isDateInYesterday(value) {
                valueField.valueLabel.text = "yesterday".localized

                return
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            valueField.valueLabel.text = dateFormatter.string(from: value)
        } else {
            valueField.valueLabel.text = valuePlaceholder
        }
    }

    @objc
    func didTapEdit() {
        let picker = DateValuePickerFieldModal(
            date: formValue,
            notSelectedName: notSelectedName,
            valueFieldName: valueFieldName
        )
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func valuePickerApplied(value: Date?) {
        setValue(value: value)
    }
}
