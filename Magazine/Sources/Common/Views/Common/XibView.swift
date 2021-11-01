import UIKit

@IBDesignable
class XibView: UIView {
    var contentView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Self.nibIdentifier, bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
//        guard let contentView = contentView else {
//            preconditionFailure("Content View must not be null")
//        }

        commonInit()
        contentView?.layer.cornerRadius = 30
        contentView?.prepareForInterfaceBuilder()
    }
}
