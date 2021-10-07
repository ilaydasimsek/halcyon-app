import Foundation

class EntryViewController: ViewController<EntryView> {
    
    init(coordinator: AppCoordinating) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
