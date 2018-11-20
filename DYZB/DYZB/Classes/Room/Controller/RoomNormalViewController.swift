//
//  RoomNormalViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/19.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController , UIGestureRecognizerDelegate {

    // MARK:- 系統回調
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
    }
    
    // MARK:- 系統畫面將出現
    override func viewWillAppear(_ animated: Bool) {
        //隱藏navigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //因為隱藏導覽列後 就不可以pop手勢返回上一頁
        //依然保持手勢(X) 不再需要 因為已經在自定義navigationController加入Pan手勢
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
    }
    
    // MARK:- 系統畫面將離開
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //顯示navigationBar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
