//
//  AppDelegate.swift.swift
//  Remember Colors
//
//  Created by Josi Salehi on 30.04.25.
//

import SwiftUI

class AppDelegate {
    
    var window: UIWindow?
    static var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }

}
