import UIKit

class ViewController<T, C>: UIViewController where T: UIView, C: Coordinator {
    let rootView: T
    let coordinator: C

    var bottomTabBarStatus: VisibilityStatus {
        return .hidden
    }

    var navigatioBarStatus: VisibilityStatus {
        return .hidden
    }

    var hideKeyboardWhenTappedAround: Bool {
        return true
    }

    /**
     Creates a nib from using the type (T) of specified view.
     */
    init(coordinator: C) {
        guard let nibView = Bundle.main.loadNibNamed(T.nibIdentifier, owner: nil)?.first as? T else {
            fatalError("Nib \(T.self) can't be loaded")
        }
        rootView = nibView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    /**
     Sets the controllers view to a specified view of type (T)
     */
    init(withView view: T, coordinator: C) {
        self.rootView = view
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
