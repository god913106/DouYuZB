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

        // 1.獲取系統的pop手勢
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.獲取手勢添加到的View中
        guard let gesView = systemGes.view else { return }
        
        // 3.獲取target/action
        // 3.1利用進行時機查看UIGestureRecognizer所有的屬性名稱
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.創建自己的Pan手勢
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隱藏push的控制器tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
