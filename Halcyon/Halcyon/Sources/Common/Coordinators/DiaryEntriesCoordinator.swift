import UIKit

protocol DiaryEntriesCoordinating where Self: Coordinatable {
    func showEntryDetails(entryId: String)
}

class DiaryEntriesCoordinator: Coordinator, DiaryEntriesCoordinating {
    
    override func start() {
        self.setViewController(as: dependencies.makeDiaryEntriesViewController(coordinator: self), animated: true)
    }

    func showEntryDetails(entryId: String) {
        let entryDetailsController = dependencies.makeEntryDetailsViewController(coordinator: self, entryId: entryId)
        self.navigationController.pushViewController(entryDetailsController, animated: true)
    }
}
