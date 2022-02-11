import Foundation
import PromiseKit

protocol DiaryEntriesFetching {
    func fetchDiaryEntries() -> Promise<[DiaryEntry]>
}

class DiaryEntriesFetcher: Fetcher, DiaryEntriesFetching {

    func fetchDiaryEntries() -> Promise<[DiaryEntry]> {
        return Promise { promiseSeal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                promiseSeal.fulfill([
                    DiaryEntry(id: "e1", title: "Diary Entry 1", creationDate: nil),
                    DiaryEntry(id: "e2", title: "Diary Entry 2", creationDate: nil),
                    DiaryEntry(id: "e3", title: "Diary Entry 3", creationDate: nil),
                    DiaryEntry(id: "e4", title: "Diary Entry 4", creationDate: nil),
                    DiaryEntry(id: "e5", title: "Diary Entry 5", creationDate: nil),
                    DiaryEntry(id: "e6", title: "Diary Entry 6", creationDate: nil),
                    DiaryEntry(id: "e7", title: "Diary Entry 7", creationDate: nil),
                ])
            }
        }
    }
}
