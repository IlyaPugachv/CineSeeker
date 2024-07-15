import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = Home.View(with: .init())
        let searchVC = Search.View(with: .init())
        let watchListVC = WatchList.View(with: .init())
        
        homeVC.title = "Home"
        searchVC.title = "Search"
        watchListVC.title = "WatchList"
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        let nav3 = UINavigationController(rootViewController: watchListVC)
        
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        watchListVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
    
    
}
