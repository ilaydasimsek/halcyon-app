import Foundation

class EntryViewController: ViewController<EntryView, AuthenticationCoordinator> {
    
    override init(coordinator: AuthenticationCoordinator) {
        super.init(coordinator: coordinator)
        prepareActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    private func prepareActions() {

    }
}
