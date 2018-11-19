//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/13.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//  因為推薦介面和遊戲介面有很多相同的代碼所以要進行抽取成父類別

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懶加載屬性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        
        let menuView = AmuseMenuView.amuseMenuView()
        
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
//        menuView.backgroundColor = UIColor.purple
        return menuView
    }()
}

// MARK:- 設置UI介面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        //將菜單的View添加到控制器的collectionView中
        collectionView.addSubview(menuView)
        
        // 設置collectionView的內邊距
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        
    }
}

// MARK:- 請求數據後展示
extension AmuseViewController {
    override func loadData() {
        
        // 1.給父類中viewModel進行賦值
        baseVM = amuseVM
        
        // 2.請求數據
        amuseVM.loadAmuseData {
            // 1.刷新表格
            self.collectionView.reloadData()
            
            // 2.2.調整數據
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()  //刪除最熱
            self.menuView.groups = tempGroups
            
            // 3.數據請求完成
            self.loadDataFinished()
            
        }
    }
}



