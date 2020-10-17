//
//  SceneDelegate.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 15/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            let url = context.url
            if let scheme = url.scheme,
                scheme.localizedCaseInsensitiveCompare("com.eve") == .orderedSame,
                let action = url.host {
                var parameters: [String: String] = [:]
                URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                    parameters[$0.name] = $0.value
                }
                if action.localizedCaseInsensitiveCompare("invite") == .orderedSame,
                    let id = parameters["id"] {
                    //TODO: Add the event to the users list of events
                }
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

