//
//  AnchorModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/16.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//https://www.jianshu.com/p/fb813cce8984

import UIKit
//import SwiftyJSON

class AnchorModel: NSObject {
    /// 房間ID
    @objc var room_id : Int = 0
    /// 房間圖片對應的URLString
    @objc var vertical_src : String = ""
    /// 判斷是手機直播還是電腦直播
    // 0 : 電腦直播(普通房間RoomNormal) 1 : 手機直播(秀場房間RoomShow)
    @objc var isVertical : Int = 0
    /// 房間名稱
    @objc var room_name : String = ""
    ///game_name
    @objc var game_name : String = ""
    
    /// 主播昵稱
    @objc var nickname : String = ""
    /// 觀看人數
    @objc var online : Int = 0
    /// 所在城市
    @objc var anchor_city : String = ""


    init(dict : [String : Any]) {

        super.init()
        
        setValuesForKeys(dict)
       
       
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
