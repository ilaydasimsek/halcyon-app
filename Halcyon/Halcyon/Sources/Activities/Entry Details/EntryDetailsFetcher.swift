import Foundation
import PromiseKit

protocol EntryDetailsFetching {
    func fetchEntry(id: String) -> Promise<DiaryEntryDetails>
}

class EntryDetailsFetcher: Fetcher, EntryDetailsFetching {
    func fetchEntry(id: String) -> Promise<DiaryEntryDetails> {
        return Promise { promiseSeal in
            self.networking.decodedRequest(FirestoreNetworkingService.entry(id: id)).done({ result in
                promiseSeal.fulfill(result)
            }).catch({error in
                promiseSeal.reject(error)
            })
        }
    }
}
