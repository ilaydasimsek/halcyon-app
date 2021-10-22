import UIKit

class ___VARIABLE_productName___ViewController: ViewController<___VARIABLE_productName___View, ___VARIABLE_coordinatorName___> {
    let fetcher: ___VARIABLE_productName___Fetching

    init(fetcher: ___VARIABLE_productName___Fetching, coordinator: ___VARIABLE_coordinatorName___) {
        self.fetcher = fetcher
        super.init(coordinator: coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }
}
