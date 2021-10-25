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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareActions()
        self.prepareUI()
    }

    private func prepareActions() {
        // Add any button actions here
    }

    private func prepareUI() {
        // Make any UI specific changes here
    }

    private func fetch() {
        // Send the fetch request here, ideally this should return a promise using PromiseKit
    }
}
