import Foundation
import UIKit

protocol ValuePickerFieldModalDelegate: AnyObject {
    func valuePickerApplied(value: String?)
}

protocol ValuePickerFieldDelegate: AnyObject {
    func valuePickerApplied(_ valuePicker: ValuePickerField, value: String?)
}

class ValuePickerFieldModal: UIViewController {
    struct UIConstants {
        static let padding: CGFloat = 10
        static let dividerHeight: CGFloat = 1
        static let height: CGFloat = 300
        static let pickerHeight: CGFloat = 250
        static let fieldsPadding: CGFloat = 40
    }

    private let notSelected: ValueFieldWithCheckbox
    private let valueSelected: ValueFieldWithCheckbox
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
    weak var pickerDelegate: UIPickerViewDelegate?
    weak var dataSource: UIPickerViewDataSource?
    weak var delegate: ValuePickerFieldModalDelegate?

    init(value: String?, notSelectedName: String = "not-selected".localized, valueFieldName: String = "select".localized) {
        self.notSelected = ValueFieldWithCheckbox(name: notSelectedName)
        self.valueSelected = ValueFieldWithCheckbox(name: valueFieldName)
        self.value = value
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

    func configureFields() {
        view.addSubview(notSelected)
        notSelected.snp.makeConstraints { (make) in
            make.top.equalTo(toolbar.snp.bottom).offset(UIConstants.padding)
            make.width.equalTo(view).offset(-UIConstants.fieldsPadding)
            make.centerX.equalTo(view)
        }

        view.addSubview(valueSelected)
        valueSelected.snp.makeConstraints { (make) in
            make.top.equalTo(notSelected.snp.bottom)
            make.width.equalTo(view).offset(-UIConstants.fieldsPadding)
            make.centerX.equalTo(view)
        }

        notSelected.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNotSelectField)))
        valueSelected.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSelectField)))

        setFieldsValue(value: value)
    }

    func configurePicker() {
        view.addSubview(picker)
        picker.snp.makeConstraints {(make) in
            make.top.equalTo(valueSelected.snp.bottom).offset(UIConstants.padding)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(UIConstants.pickerHeight)
        }

//        if let date = dateValue {
//            picker.setDate(date, animated: true)
//        }

        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self.pickerDelegate
        picker.dataSource = self.dataSource
    }

    func setFieldsValue(value: Any?) {
        switch value {
        case nil:
            notSelected.isChecked = true
            valueSelected.isChecked = false
            picker.isHidden = true
        default:
            notSelected.isChecked = false
            valueSelected.isChecked = true
            picker.isHidden = false
        }
    }

    @objc
    func didTapApplyButton() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: value)
    }

    @objc
    func didTapCancelIcon() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: nil)
    }

    @objc
    func didTapSelectField() {
        setFieldsValue(value: value)
    }

    @objc
    func didTapNotSelectField() {
        dismiss(animated: true, completion: nil)
        delegate?.valuePickerApplied(value: nil)
    }
}

class ValuePickerField: UIViewController, ValuePickerFieldModalDelegate {
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
    var formValue: String?
    weak var delegate: ValuePickerFieldDelegate?

    init(name: String, placeholder: String = "") {
        valueField = ValueField(name: name)
        valueFieldName = name
        notSelectedName = ""
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

    func setValue(value: String?) {
        self.formValue = value
        if let value = value {
            valueField.valueLabel.text = value
        } else {
            valueField.valueLabel.text = valuePlaceholder
        }
    }

    @objc
    func didTapEdit() {
        let picker = ValuePickerFieldModal(value: formValue)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func valuePickerApplied(value: String?) {
        delegate?.valuePickerApplied(self, value: value)
        setValue(value: value)
    }
}
