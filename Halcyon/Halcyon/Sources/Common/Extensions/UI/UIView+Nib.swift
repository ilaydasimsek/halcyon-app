import UIKit

extension UIView {
    static var nibName: String {
        return String(describing: self)
    }

    func fix(inView view: UIView) -> Void {
        view.addSubview(self)
        self.frame = view.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutIfNeeded()
    }
}
