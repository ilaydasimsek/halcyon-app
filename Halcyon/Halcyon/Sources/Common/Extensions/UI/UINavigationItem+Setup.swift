import Foundation
import UIKit

extension UINavigationItem {

    func setOpaque(withColor color: UIColor? = nil) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = color
        self.scrollEdgeAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.compactAppearance = navigationBarAppearance
    }

    func setTransparent() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        self.scrollEdgeAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.compactAppearance = navigationBarAppearance
    }
}
