//
//  CycleModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/26.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
//import SwiftyJSON

class CycleModel: NSObject {
    
    // 標題
    @objc var title : String = ""
    
    // 展示的圖片地址
    @objc var pic_url : String = ""
    
    // 主播信息對應的字典
    @objc var room : [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    // 主播信息對應的模型對象
    @objc var anchor : AnchorModel?
    
    // MARK:- 自定義構造函數
    init(dict : [String : NSObject]) {

        super.init()
        
        setValuesForKeys(dict)
   
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
