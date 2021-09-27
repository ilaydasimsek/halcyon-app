import Foundation
import PromiseKit


protocol MainScreenFetching {
    func getBaseScreen(screenId: String) -> Promise<MainScreen>
}

class MainScreenFetcher: Fetcher, MainScreenFetching {

    func getBaseScreen(screenId: String) -> Promise<MainScreen> {
        return Promise { promiseSeal in
            self.networking.request(MainScreenService.screen(info: ScreenInformation(id: screenId, action: .showBaseScreen))).done({ data in
                guard let mainScreen = try? MainScreen.decode(data) else {
                    promiseSeal.reject(RequestError.networkError)
                    return
                }
                promiseSeal.fulfill(mainScreen)
            }).catch({error in
                promiseSeal.reject(error)
            })
        }
    }
}
