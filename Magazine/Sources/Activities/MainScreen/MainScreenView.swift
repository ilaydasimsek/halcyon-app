import UIKit

class MainScreenView: UIView {
    @IBOutlet weak var screenNameLabel: UILabel!

    func setup(with mainScreen: MainScreen) {
        self.screenNameLabel.text = mainScreen.name
    }
}
