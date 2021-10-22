import UIKit

extension UIColor {
    static var primary: UIColor {
        return Self.color(named: "Primary")
    }

    static var secondary:  UIColor {
        return Self.color(named: "Secondary")
    }

    static var paleGray: UIColor {
        return Self.color(named: "PaleGray")
    }

    static var ivory: UIColor {
        return Self.color(named: "Ivory")
    }

    static var peach: UIColor {
        return Self.color(named: "Peach")
    }

    static var lightPurple: UIColor {
        return Self.color(named: "LightPurple")
    }

    static var black: UIColor {
        return Self.color(named: "Black")
    }

    static var darkGray: UIColor {
        return Self.color(named: "DarkGray")
    }

    static func color(named name: String) -> UIColor {
        return UIColor(named: name, in: Bundle(for: AppDelegate.self), compatibleWith: nil)!
    }
}
