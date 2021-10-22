import UIKit

@IBDesignable class BasicButton: UIView {
    private lazy var button: UIButton = {
       return UIButton()
    }()

    @IBInspectable var buttonTitleColor: UIColor = UIColor.ivory
    @IBInspectable var color: UIColor = UIColor.primary
    @IBInspectable var buttonTitle: String = ""

    private let baseCornerRadius: CGFloat = 12
    private let font: UIFont = UIFont.systemFont(ofSize: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setAttributes()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setAttributes()
    }

    func addTarget(controller: UIViewController, action: Selector) {
        self.button.addTarget(controller,
                              action: action,
                              for: .touchUpInside)
    }
}

// MARK: - View Setup
private extension BasicButton {

    func setupView() {
        addSubview(button)
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.setAttributes()
    }

    func setAttributes() {
        button.backgroundColor = color
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
        
        button.setAttributedTitle(attributedTitle, for: .normal)
    }
}
