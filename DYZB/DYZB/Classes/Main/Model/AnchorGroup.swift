//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/16.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//https://www.jianshu.com/p/fb813cce8984

import UIKit
//import SwiftyJSON

class AnchorGroup: BaseGameModel {
    /// 該組中對應的房間信息
   @objc var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }

    /// 組顯示的圖標
    @objc var icon_name : String = "home_header_normal"
  
    /// 定義主播的模型對象數组
    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    

}
