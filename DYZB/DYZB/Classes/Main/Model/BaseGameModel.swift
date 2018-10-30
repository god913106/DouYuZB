//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/18.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//https://www.jianshu.com/p/fb813cce8984

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定義屬性
   @objc var tag_name : String = ""
   @objc var icon_url : String = ""
    
    // MARK:- 自定義構造函數
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
