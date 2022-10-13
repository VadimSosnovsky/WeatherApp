//
//  AppDelegate.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit
import SDWebImageSVGCoder

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        let mainVC = MainViewController()
        let navigationVC = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationVC.viewControllers = [mainVC]
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

