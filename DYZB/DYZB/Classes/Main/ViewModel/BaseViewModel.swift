//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/18.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//  通常是找代碼比較少的抽取成父類
//https://www.jianshu.com/p/fb813cce8984

import UIKit

class BaseViewModel {
   lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    //請求主播訊息
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1.對界面進行處理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            

            // 2.判斷是否分组數據
            if isGroupData {
                // 2.1.遍歷數组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else  {
                // 2.1.創建组
                let group = AnchorGroup()
                
                // 2.2.遍歷dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                // 2.3.将group,添加到anchorGroups
                self.anchorGroups.append(group)
            }

            // 3.完成回調
            finishedCallback()
        }
    }
}

