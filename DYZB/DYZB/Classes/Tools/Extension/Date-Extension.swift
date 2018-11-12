//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/16.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
