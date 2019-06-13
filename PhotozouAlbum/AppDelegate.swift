//
//  AppDelegate.swift
//  PhotozouAlbum
//
//  Created by 井草俊輔 on 2019/06/08.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import UIKit
import APIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let photoListVC = PhotoListViewController.makeInstance()
        let model = PhotoListModel()
        let presenter = PhotoListPresenter(view: photoListVC, model: model)
        photoListVC.inject(presenter: presenter)
        window?.rootViewController = photoListVC
        window?.makeKeyAndVisible()
        return true
    }

}

