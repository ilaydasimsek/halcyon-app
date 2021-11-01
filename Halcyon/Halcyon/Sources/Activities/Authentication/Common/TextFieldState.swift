import UIKit

enum TextFieldState {
    case normal, error

    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return UIColor.ivory
        case .error:
            return UIColor.ivory
        }
    }

    var borderColor: CGColor {
        switch self {
        case .normal:
            return UIColor.ivory.cgColor
        case .error:
            return UIColor.monzaRed.withAlphaComponent(0.8).cgColor
        }
    }
}
