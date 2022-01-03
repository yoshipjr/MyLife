import UIKit

final class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    required init?(
        coder aDecoder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(
        rootViewController: UIViewController
    ) {
        super.init(rootViewController: rootViewController)
    }

    override init(
        navigationBarClass: AnyClass?,
        toolbarClass: AnyClass?
    ) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }

    override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    convenience init(
        rootVC: UIViewController,
        naviBarClass: AnyClass?,
        toolbarClass: AnyClass?
    ) {
        self.init(navigationBarClass: naviBarClass, toolbarClass: toolbarClass)
        self.viewControllers = [rootVC]
    }
}
