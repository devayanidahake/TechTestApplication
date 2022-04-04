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
        // Check if the device is jailbroken
        checkIfDeviceIsJailbroken()
    }
}

extension SceneDelegate {
    func checkIfDeviceIsJailbroken() {
        let isDeviceJailbreak = UIDevice.current.checkisDeviceJailBrocken()
        if isDeviceJailbreak {
            showApplicationAlertAndQuitApplication()
        }
    }
    
    private func showApplicationAlertAndQuitApplication() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Get the root view controller to show alert
            self.window?.rootViewController = UIStoryboard(name: Constants.StoryboardXIBNames.main,
                                                           bundle: nil).instantiateInitialViewController()
            guard let sourceVC = self.window?.rootViewController else { return }
            // Remove the first screen
            (sourceVC as? UINavigationController)?.visibleViewController?.removeFromParent()
            // Show alert to user
            Alert.present(title: Constants.ErrorMessages.jailbrokenDevice, message: "", actions: .okay(handler: {
                self.suspendApplecation()
            }), from: sourceVC)
        }
    }
    
    private func suspendApplecation() {
       UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
