import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }

        get {
            self.layer.cornerRadius
        }
    }
}

extension UIView {

    var absoluteCenter: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }

    func setEqualWidth(to view: UIView) {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
}
