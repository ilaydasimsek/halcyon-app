import Foundation
import PromiseKit


protocol ProfileFetching {
    func getBaseScreen(screenId: String) -> Promise<Profile>
}

class ProfileFetcher: Fetcher, ProfileFetching {

    func getBaseScreen(screenId: String) -> Promise<Profile> {
        return Promise { promiseSeal in
            self.networking.request(UserService.profile(userId: "123456")).done({ data in
                guard let profile = try? Profile.decode(data) else {
                    promiseSeal.reject(RequestError.networkError)
                    return
                }
                promiseSeal.fulfill(profile)
            }).catch({error in
                promiseSeal.reject(error)
            })
        }
    }
}
