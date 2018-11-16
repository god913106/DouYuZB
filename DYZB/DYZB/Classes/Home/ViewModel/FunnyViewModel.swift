//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/16.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//
/*
 這裡怎麼處理呢 先把result轉成一個字典 字典裡面根據data這個鍵去取我們的數組
 拿到數組 再把數組裡面每個字典進行遍歷 遍歷之後把他轉成一個anchorGroup的一個對象 但是我們現在這個數據是不是這個樣子呢
 這個data裡面就是一個一個主播的數據
 */

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}

//http://capi.douyucdn.cn/api/v1/getColumnList 獲取父頻道
// 1網遊競技 15单機熱遊 9手遊休閒 2娛樂天地 8顏值 11科技教育 18語音直播 13正能量
