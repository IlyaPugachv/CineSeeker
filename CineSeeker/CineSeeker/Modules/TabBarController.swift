import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = Home.View(with: .init())
        let searchVC = Search.View(with: .init())
        let watchListVC = WatchList.View(with: .init())
        
        homeVC.title = .Localization.home
        searchVC.title = .Localization.search
        watchListVC.title = .Localization.watchList
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        let nav3 = UINavigationController(rootViewController: watchListVC)
        
        
        homeVC.tabBarItem = UITabBarItem(title: .Localization.home, image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: .Localization.search, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        watchListVC.tabBarItem = UITabBarItem(title: .Localization.watchList, image: UIImage(systemName: "bookmark"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}
