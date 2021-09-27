enum ScreenAction {
    case showBaseScreen
    case showScreen(detailId: String)
    case navigateInsideNavBar
}

struct ScreenInformation {
    let id: String
    let action: ScreenAction
}
