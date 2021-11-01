import UIKit

class AuthTextField: XibView {

    @IBInspectable var titleText: String?
    @IBInspectable var secure: Bool = false

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!

    var delegate: UITextFieldDelegate? {
        set {
            textField.delegate = newValue
        } get {
            return textField.delegate
        }
    }

    var value: String {
        return self.textField.text ?? ""
    }

    private let font: UIFont = UIFont.bold18

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 85)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }

    private func prepareView() {
        titleLabel.text = titleText
        titleLabel.font = font

        textField.isSecureTextEntry = secure
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.returnKeyType = .continue
        setState(.normal)
    }

    func setTag(_ tag: Int) {
        self.textField.tag = tag
        self.tag = tag
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareView()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return textField.resignFirstResponder()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return textField.becomeFirstResponder()
    }

    func setState(_ state: TextFieldState) {
        textField.backgroundColor = state.backgroundColor
        textField.layer.borderColor = state.borderColor
    }
}
