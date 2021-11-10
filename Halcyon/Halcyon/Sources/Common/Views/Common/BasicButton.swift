import UIKit

@IBDesignable class BasicButton: UIButton {

    @IBInspectable var buttonTitleColor: UIColor = UIColor.ivory
    @IBInspectable var color: UIColor = UIColor.primary
    @IBInspectable var buttonTitle: String = ""

    private let baseCornerRadius: CGFloat = 12
    private let font: UIFont = UIFont.bold20

    override func layoutSubviews() {
        super.layoutSubviews()
        self.prepareView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.prepareView()
    }
}

// MARK: - View Setup
private extension BasicButton {

    func prepareView() {
        self.backgroundColor = color
        self.setAttributedTitle(title: buttonTitle)
        cornerRadius = baseCornerRadius
        clipsToBounds = true
    }

    func setAttributedTitle(title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: buttonTitleColor,
            .font: font,
        ]
        let attributedTitle = NSAttributedString(string: title,
                                                 attributes: attributes)
        
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
