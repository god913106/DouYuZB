//
//  MainViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/5.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
    
    private func addChildVC(storyName : String) {
        //1.通過storyboard獲取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.將childVCv作為子控制器
        addChild(childVC)
    }

}
