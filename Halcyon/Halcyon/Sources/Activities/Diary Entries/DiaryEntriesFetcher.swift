import Foundation
import PromiseKit

protocol DiaryEntriesFetching {

}

class DiaryEntriesFetcher: Fetcher, DiaryEntriesFetching {

    func fetchDiaryEntries() -> Promise<DiaryEntries> {
        return Promise { promiseSeal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                promiseSeal.fulfill(DiaryEntries(items: [
                    DiaryEntryItem(title: "Diary Entry 1", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 2", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 3", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 4", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 5", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 6", creationDate: nil),
                    DiaryEntryItem(title: "Diary Entry 7", creationDate: nil),
                ]))
            }
        }
    }
}
