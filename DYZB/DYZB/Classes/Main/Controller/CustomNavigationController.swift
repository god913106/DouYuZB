//
//  CustomNavigationController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/19.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隱藏push的控制器tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
