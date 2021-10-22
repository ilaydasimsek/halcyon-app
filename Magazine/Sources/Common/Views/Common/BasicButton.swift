import UIKit

@IBDesignable class BasicButton: UIButton {

    @IBInspectable var titleColour: UIColor = .white {
        didSet {
            setTitleColor(titleColour, for: .normal)
        }
    }

    @IBInspectable var bgColour: UIColor = UIColor.gray {
        didSet {
            backgroundColor = bgColour
        }
    }

    @IBInspectable var buttonTitle: String = "Button" {
        didSet {
            setTitle(buttonTitle, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setAttributes()
    }

    public func setAttributes() {
        setTitleColor(titleColour, for: .normal)
        backgroundColor = bgColour
        setTitle(buttonTitle, for: .normal)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        setAttributes()

        layer.cornerRadius = 0.5 * bounds.size.height
        clipsToBounds = true
    }
}
