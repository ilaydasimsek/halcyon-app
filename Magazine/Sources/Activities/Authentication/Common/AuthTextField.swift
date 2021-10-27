import UIKit

class AuthTextField: XibView {

    @IBInspectable var titleText: String?
    @IBInspectable var secure: Bool = false

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var value: String {
        return self.textField.text ?? ""
    }

    private let font: UIFont = UIFont.bold18

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 85)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }

    private func prepareView() {
        titleLabel.text = titleText
        titleLabel.font = font
        textField.isSecureTextEntry = secure
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareView()
    }
}
