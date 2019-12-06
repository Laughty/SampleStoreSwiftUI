//
//  SceneDelegate.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 30/11/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var commonContext: CommonContext!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if ProcessInfo.processInfo.arguments.contains("STORE_UI_TESTING") {
            commonContext = TestingContext()
        } else {
            commonContext = DefaultContext()
        }
        
        let productListView = ProductListView(commonContext)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: productListView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

