//
//  AppDelegate.swift
//  CustomTabbar
//
//  Created by Tuan Mai A. on 5/8/17.
//  Copyright © 2017 Tuan Mai A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = TabbarCustomViewController()
        let demoVC = DemoViewController()
        demoVC.vcl = UIColor.brown
        let demoVC2 = DemoViewController()
        demoVC2.vcl = UIColor.cyan
        let demoVC3 = DemoViewController()
        demoVC3.vcl = UIColor.yellow
        let demoVC4 = DemoViewController()
        demoVC4.vcl = UIColor.blue
        let demoVC5 = DemoViewController()
        demoVC5.vcl = UIColor.gray
        
        let vcs = [demoVC, demoVC2, demoVC3, demoVC4, demoVC5]
        
        vc.viewControllers = vcs
        vc.datasource = self
        vc.delegate = self
        vc.isScroll = true
        window?.rootViewController = vc
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: TabbarCustomViewControllerDatasource, TabbarCustomViewControllerDelegate {
    
    func viewForItemInTabbar(index: Int, isSelect: Bool) -> UIView? {
        guard let view = Bundle.main.loadNibNamed("TabbarItemView", owner: nil, options: nil)?[0] as? TabbarItemView else { return UIView() }
        view.label.text = isSelect ? "ITEM: \(index)" : "item: \(index)"
        return view
    }
    
    func sizeForItemInTabbar(index: Int) -> CGSize {
        if index == 2 {
            return CGSize(width: 75, height: 55)
        }
        return CGSize.zero
    }
    func tabBarController(_ tabBarController: TabbarCustomViewController, shouldSelect viewController: UIViewController) -> Bool {
        print("shouldSelect ViewController")
        if viewController.view.backgroundColor == UIColor.yellow {
            return false
        }
        return true
    }
    
    func tabBarController(_ tabBarController: TabbarCustomViewController, _ viewController: UIViewController, didEndAnimation animation: Bool?) {
        print("didEndAnimation")
    }
}

