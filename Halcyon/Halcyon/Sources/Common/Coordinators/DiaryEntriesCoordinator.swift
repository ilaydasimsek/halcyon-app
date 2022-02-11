import UIKit

protocol DiaryEntriesCoordinating where Self: Coordinatable {
    func showEntryDetails()
}

class DiaryEntriesCoordinator: Coordinator, DiaryEntriesCoordinating {
    
    override func start() {
        self.setViewController(as: dependencies.makeDiaryEntriesViewController(coordinator: self), animated: true)
    }

    func showEntryDetails() {
        let entryDetailsController = dependencies.makeEntryDetailsViewController(coordinator: self)
        self.navigationController.pushViewController(entryDetailsController, animated: true)
    }
}
