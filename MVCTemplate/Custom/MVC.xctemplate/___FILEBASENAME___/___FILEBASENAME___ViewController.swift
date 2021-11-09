import UIKit

class ___VARIABLE_productName___ViewController: ViewController<___VARIABLE_productName___View> {
    let fetcher: ___VARIABLE_productName___Fetching
    let coordinator: ___VARIABLE_coordinatorName___

    init(fetcher: ___VARIABLE_productName___Fetching, coordinator: ___VARIABLE_coordinatorName___) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
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

        /**
            Send the fetch request here, ideally this should return a promise using PromiseKit
            To listen to the returned promise:
                Promise<Data>.done({ data in
                   // Handle success
                }).catch({ error in
                   // Handle error
                })
        */
    }
}
