import Foundation
import UIKit

final class TabBarController: UITabBarController {

    enum TabBarItem {
        case home
        case search
        case favorite
        #if DEBUG
        case debug
        #endif

        var item: UITabBarItem {
            switch self {
                case .home:
                    let homeImage = ImageResource.Menu.home
                    return UITabBarItem(
                        title: "ホーム",
                        image: homeImage,
                        selectedImage: homeImage?.withTintColor(.blue)
                    )
                case .search:
                    let searchImage = ImageResource.Menu.search
                    return UITabBarItem(
                        title: "見つける",
                        image: searchImage,
                        selectedImage: searchImage?.withTintColor(.blue)
                    )

                case .favorite:
                    let favoriteImage = ImageResource.Menu.favorite
                    return UITabBarItem(
                        title: "お気に入り",
                        image: favoriteImage,
                        selectedImage: favoriteImage?.withTintColor(.blue)
                    )

                #if DEBUG
                case .debug:
                    let debugImage = ImageResource.Menu.debug
                    return UITabBarItem(
                        title: "DEBUG",
                        image: debugImage,
                        selectedImage: debugImage?.withTintColor(.blue)
                    )
                #endif
            }
        }
    }

    private let homeScreen: NavigationController = {
        let homeScreen = NavigationController(rootVC: HomeViewController(), naviBarClass: nil, toolbarClass: nil)
        homeScreen.tabBarItem = TabBarItem.home.item
        return homeScreen
    }()

    private let searchScreen: NavigationController = {
        let debugScreen = NavigationController(rootVC: SearchViewController(), naviBarClass: nil, toolbarClass: nil)
        debugScreen.tabBarItem = TabBarItem.search.item
        return debugScreen
    }()

    private let favoriteScreen: NavigationController = {
        let favoriteScreen = NavigationController(rootVC: FavoriteViewController(), naviBarClass: nil, toolbarClass: nil)
        favoriteScreen.tabBarItem = TabBarItem.favorite.item
        return favoriteScreen
    }()

    private let debugScreen: NavigationController = {
        let debugScreen = NavigationController(rootVC: DebugViewController(), naviBarClass: nil, toolbarClass: nil)
        debugScreen.tabBarItem = TabBarItem.debug.item
        return debugScreen
    }()

    private var tabViewControllers: [UIViewController] {
        var viewControllers = [ homeScreen, searchScreen, favoriteScreen]
        #if DEBUG
        viewControllers.append(debugScreen)
        #endif
        return viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorResource.Base.white

        self.viewControllers = tabViewControllers

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ColorResource.Base.white

            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}
