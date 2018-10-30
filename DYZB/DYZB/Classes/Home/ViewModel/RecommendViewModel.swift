//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/16.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

/*
 1> 请求0/1数组,并转成模型对象
 2> 对数据进行排序
 3> 显示的HeaderView中内容
 */

import UIKit
//import SwiftyJSON

class RecommendViewModel : BaseViewModel {
    //    // MARK:- 懶加載屬性
//    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    @objc lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 發送網路請求
extension RecommendViewModel {
    
    // 請求推薦數據
    func requestData(finishCallback : @escaping () -> ()) {
        // 1.定義參數
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // 2.創建Group
        let dGroup = DispatchGroup()
        
        
        // 3.請求第一部份推薦數據OK
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            // 1.將result轉成字典類型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根據data該key,獲取數组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍歷數组,獲取字典,并且將字典轉成模型對象
            // 3.1.設置组的屬性
            self.bigDataGroup.tag_name = "熱門"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
//            for group in self.bigDataGroup.anchors {
//                print("group.nickname: \(group.nickname)")
//                
//            }
            
            dGroup.leave()
            
        }
        
        // 4.請求第二部份顏值數據OK
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.將result轉成字典類型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根據data該key,獲取數组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍歷數组,獲取字典,并且將字典轉成模型對象
            // 3.1.設置组的屬性
            self.prettyGroup.tag_name = "顏值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            
            for data in dataArray {
                let anchor = AnchorModel(dict: data)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        
        
        
        // 5.請求後面部份遊戲數據
        dGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1540281147
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        
        // 6.所有的数据都请求到,之后进行排序
        
        dGroup.notify(queue: DispatchQueue.main) {
         
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    // 請求無限輪播的數據 閉包的用意是告訴我們拿到數據了
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            print(result)
            // 1.獲取整體字典數據
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根據data的key獲取數據
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典轉模型的對象
            for data in dataArray {
                self.cycleModels.append(CycleModel(dict: data))
            }
            
            finishCallback()
        }
    }
}
