//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/13.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//  因為推薦介面和遊戲介面有很多相同的代碼所以要進行抽取成父類別

import UIKit



class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懶加載屬性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()

}



// MARK:- 請求數據後展示
extension AmuseViewController {
    override func loadData() {
        
        // 1.給父類中viewModel進行賦值
        baseVM = amuseVM
        
        // 2.請求數據
        amuseVM.loadAllAmuseData {
            // 1.展示全部遊戲數據
            self.collectionView.reloadData()
            
        }
    }
}



