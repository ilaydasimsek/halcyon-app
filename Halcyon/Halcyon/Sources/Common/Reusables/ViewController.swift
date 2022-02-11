import UIKit

enum VisibilityStatus {
    case hidden, visible
}

enum NavigationBarStyle {
    case light, dark, transparent

    var backgroundColor: UIColor? {
        switch self {
        case .light:
            return .ivory
        case .dark:
            return .black
        case .transparent:
            return nil
        }
    }

    var textColor: UIColor {
        switch self {
        case .light:
            return .black
        case .dark, .transparent:
            return .ivory
        }
    }

    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .light:
            return .darkContent
        case .dark, .transparent:
            return .lightContent
        }
    }
}

class ViewController<T: UIView>: UIViewController {
    let rootView: T
    let baseCoordinator: Coordinatable

    var bottomTabBarStatus: VisibilityStatus {
        return .hidden
    }

    var navigatioBarStatus: VisibilityStatus {
        return .visible
    }

    var hideKeyboardWhenTappedAround: Bool {
        return true
    }

    var navigationBarStyle: NavigationBarStyle {
        return .light
    }

    var navigationBarTitle: String? {
        return nil
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /**
     Creates a nib from using the type (T) of specified view.
     */
    init(baseCoordinator: Coordinatable) {
        guard let nibView = Bundle.main.loadNibNamed(T.nibName, owner: nil)?.first as? T else {
            fatalError("Nib \(T.self) can't be loaded")
        }
        rootView = nibView
        self.baseCoordinator = baseCoordinator
        super.init(nibName: nil, bundle: nil)
    }

    /**
     Sets the controllers view to a specified view of type (T)
     */
    init(withView view: T, baseCoordinator: Coordinatable) {
        self.rootView = view
        self.baseCoordinator = baseCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNeedsStatusBarAppearanceUpdate()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if (hideKeyboardWhenTappedAround) {
            addHideKeyboardGesture()
        }
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }
}

// MARK: - Controller Setup
extension ViewController {

    private func setup() {
        self.hidesBottomBarWhenPushed = self.bottomTabBarStatus == .hidden
        setupNavigationBar()
        setupNavigationItem()
        setupBackButton()
    }

    private func setupNavigationBar() {
        let hidden = self.navigatioBarStatus == .hidden
        let navigationController = tabBarController?.navigationController ?? navigationController
        navigationController?.setNavigationBarHidden(hidden, animated: !hidden)

        guard !hidden, let navBar = navigationController?.navigationBar else { return }

        navBar.barTintColor = navigationBarStyle.backgroundColor
        navBar.setBackgroundImage(nil, for: .default)
        navBar.tintColor = navigationBarStyle.textColor
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationBarStyle.textColor,
                                      NSAttributedString.Key.font: UIFont.bold16]
    }

    private func setupNavigationItem() {
        let navigationItem = tabBarController?.navigationItem ?? navigationItem

        navigationItem.title = self.navigationBarTitle
        if self.navigationBarStyle == .transparent {
            navigationItem.setTransparent()
        } else {
            navigationItem.setOpaque(withColor: navigationBarStyle.backgroundColor)
        }
    }

    private func setupBackButton() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let navigationItem = tabBarController?.navigationItem ?? navigationItem
        navigationItem.backBarButtonItem = backButtonItem
    }
}

private extension UIViewController {

    func addHideKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
