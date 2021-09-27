import UIKit

extension Bundle {

    func loadNib<T: UIView>(ofType _: T.Type) -> T {
        guard let nibView = Bundle.main.loadNibNamed(T.nibIdentifier, owner: nil)?.first as? T else {
            fatalError("Nib \(T.self) can't be loaded")
        }
        return nibView
    }
}
