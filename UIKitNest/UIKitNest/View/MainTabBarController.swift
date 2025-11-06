import UIKit

class MainTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()

		let homeViewController = HomeViewController()
		homeViewController.title = "ホーム"
		homeViewController.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

		let settingsViewController = SettingsViewController()
		settingsViewController.title = "設定"
		settingsViewController.tabBarItem = UITabBarItem(title: "設定", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))

		viewControllers = [
			UINavigationController(rootViewController: homeViewController),
			UINavigationController(rootViewController: settingsViewController)
		]
	}
}
