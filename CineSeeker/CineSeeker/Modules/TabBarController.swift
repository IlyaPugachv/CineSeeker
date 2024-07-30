import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = Home.View(with: .init())
        let searchVC = Search.View(with: .init())
        let watchListVC = WatchList.View(with: .init())
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        let nav3 = UINavigationController(rootViewController: watchListVC)
        
        searchVC.title = "Search"
        watchListVC.title = "Watch list"
        
        homeVC.tabBarItem = UITabBarItem(title: .Localization.home, image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: .Localization.search, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        watchListVC.tabBarItem = UITabBarItem(title: .Localization.watchList, image: UIImage(systemName: "bookmark"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3], animated: false)
        
        configureTabBarAppearance()
        configureNavigationBarAppearance()
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .Colors.Font.darkGray
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        tabBar.isTranslucent = false
    }
    
    private func configureNavigationBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .Colors.Font.darkGray
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.systemBlue
        UINavigationBar.appearance().isTranslucent = false
    }
}

