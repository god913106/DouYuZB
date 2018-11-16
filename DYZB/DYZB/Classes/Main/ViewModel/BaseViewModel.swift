//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/18.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//  通常是找代碼比較少的抽取成父類
/*
 這裡怎麼處理呢 先把result轉成一個字典 字典裡面根據data這個鍵去取我們的數組
 拿到數組 再把數組裡面每個字典進行遍歷 遍歷之後把他轉成一個anchorGroup的一個對象 但是我們現在這個數據是不是這個樣子呢
 FunnyViewModel的這個data裡面就是一個一個主播的數據
 */
//https://www.jianshu.com/p/fb813cce8984

import UIKit

class BaseViewModel {
  @objc lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    //請求主播訊息
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1.對界面進行處理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            

            // 2.判斷是否分组數據
            // if 分组 bool值
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

                // 2.3.將group,添加到anchorGroups
                self.anchorGroups.append(group)
            }

            // 3.完成回調
            finishedCallback()
        }
    }
}

