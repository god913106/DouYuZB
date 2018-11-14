//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/13.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
//    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    //之後請求的數據給返回
    func loadAllAmuseData(finishedCallback : @escaping () -> ()) {
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
        
//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
//
//            // 1. 獲取到數據
//            guard let resultDict = result as? [String : Any] else { return }
//            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
//
//            // 2.字典轉模型
//            for dict in dataArray {
//                //AnchorGroup(dict: dict)現在拿到這個模型後你要把他保存起來 一般情況下是定義一個數組
//                self.anchorGroups.append(AnchorGroup(dict: dict))
//                //                print(dict)
//            }
//
//            // 3.完成回調
//            finishedCallback()
//
//        }
    }
}
