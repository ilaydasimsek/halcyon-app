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

    static var monzaRed: UIColor {
        return Self.color(named: "MonzaRed")
    }

    /**
        Returns a custom UIColor in AppDelegate's Bundle
     
        - Important:
        Event though AppDelegate's Bundle is equal to Bundle.main, it must be given specifiaclly to init, because
        the xib  can't find the correct Bundle for IBDesignable's while rendering a color in the interface builder.
        Refer to https://developer.apple.com/forums/thread/665826?answerId=683969022#683969022
        for details
     */

    static func color(named name: String) -> UIColor {
        return UIColor(named: name, in: Bundle(for: AppDelegate.self), compatibleWith: nil)!
    }
}
