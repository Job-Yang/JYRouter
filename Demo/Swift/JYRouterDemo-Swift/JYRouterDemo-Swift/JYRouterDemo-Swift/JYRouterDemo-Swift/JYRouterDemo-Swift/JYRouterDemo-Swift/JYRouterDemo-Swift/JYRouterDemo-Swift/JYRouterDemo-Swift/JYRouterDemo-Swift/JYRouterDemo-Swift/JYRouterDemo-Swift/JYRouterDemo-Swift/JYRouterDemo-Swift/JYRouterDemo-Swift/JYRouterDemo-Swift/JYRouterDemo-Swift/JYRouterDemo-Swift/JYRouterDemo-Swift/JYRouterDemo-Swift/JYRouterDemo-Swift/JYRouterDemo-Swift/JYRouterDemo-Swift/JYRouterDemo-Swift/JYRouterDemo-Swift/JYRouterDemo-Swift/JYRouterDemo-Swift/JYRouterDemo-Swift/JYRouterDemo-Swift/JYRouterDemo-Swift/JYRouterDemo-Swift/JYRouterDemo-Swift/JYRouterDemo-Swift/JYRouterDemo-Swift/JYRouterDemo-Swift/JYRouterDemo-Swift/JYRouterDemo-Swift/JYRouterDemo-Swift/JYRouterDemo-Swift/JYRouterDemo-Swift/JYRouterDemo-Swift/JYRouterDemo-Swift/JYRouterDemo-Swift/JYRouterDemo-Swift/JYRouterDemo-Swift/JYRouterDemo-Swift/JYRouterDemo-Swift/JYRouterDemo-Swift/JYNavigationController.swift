//
//  JYNavigationController.swift
//  JYRouterDemoForSwift
//
//  Created by 杨权 on 2017/1/3.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

import UIKit

class JYNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }

    func setNavigationBar() {
        //设置NavigationBar背景颜色
        UINavigationBar.appearance().isTranslucent = false;
        UINavigationBar.appearance().barTintColor = .white;
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage();
    }

}
