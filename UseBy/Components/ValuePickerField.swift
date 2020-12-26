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
    weak var pickerDelegate: UIPickerViewDelegate?
    weak var dataSource: UIPickerViewDataSource?
    weak var delegate: ValuePickerFieldModalDelegate?

    init(value: String?) {
        self.value = value
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        picker.delegate = self.pickerDelegate
        picker.dataSource = self.dataSource

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
        delegate?.valuePickerApplied(value: value)
    }

    @objc
    func didTapCancelIcon() {
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
    var valuePlaceholder: String = ""
    var tag: Int = 0
    var formValue: String?
    weak var delegate: ValuePickerFieldDelegate?

    init(name: String, placeholder: String = "") {
        valueField = ValueField(name: name)
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
