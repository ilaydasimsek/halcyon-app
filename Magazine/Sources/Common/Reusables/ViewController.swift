import UIKit

class ViewController<T: UIView>: UIViewController {
    let rootView: T

    var bottomTabBarStatus: VisibilityStatus {
        return .hidden
    }

    var navigatioBarStatus: VisibilityStatus {
        return .hidden
    }

    /**
     Creates a nib from using the type (T) of specified view.
     */
    init() {
        guard let nibView = Bundle.main.loadNibNamed(T.nibIdentifier, owner: nil)?.first as? T else {
            fatalError("Nib \(T.self) can't be loaded")
        }
        rootView = nibView
        super.init(nibName: nil, bundle: nil)
    }

    /**
     Sets the controllers view to a specified view of type (T)
     */
    init(withView view: T) {
        self.rootView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setup()
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }

    enum VisibilityStatus {
        case hidden, visible
    }
}

// MARK: - Controller Setup
extension ViewController {

    private func setup() {
        self.hidesBottomBarWhenPushed = self.bottomTabBarStatus == .hidden
        self.navigationController?.setNavigationBarHidden(self.navigatioBarStatus == .hidden,
                                                          animated: false)
    }
}
