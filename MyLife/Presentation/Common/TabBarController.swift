import Foundation
import UIKit

final class TabBarController: UITabBarController {

    enum TabbarItem {
        case home
        case search
        case favorite
        #if DEBUG
        case debug
        #endif

        var tabbarItem: UITabBarItem {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorResource.Base.white
    }
}

