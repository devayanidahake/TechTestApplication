//
//  SceneDelegate.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        checkIfDeviceIsJailbroken()
    }
}

extension SceneDelegate {
    func checkIfDeviceIsJailbroken() {
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        if UIDevice.current.isJailBroken {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                guard let sourceVC = self.window?.rootViewController else { return }
                (sourceVC as? UINavigationController)?.visibleViewController?.removeFromParent()
                Alert.present(title: Constants.ErrorMessages.jailbrokenDevice, message: "", actions: .okay(handler: {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                }), from: sourceVC)
            }
        }
    }
}
