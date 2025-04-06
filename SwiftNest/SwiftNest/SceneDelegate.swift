import Foundation
import Singleton
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("scene: \(scene)")
        print("session: \(session)")
        print("connectionOptions: \(connectionOptions)")
        Singleton.shared.hoge()
    }
}
