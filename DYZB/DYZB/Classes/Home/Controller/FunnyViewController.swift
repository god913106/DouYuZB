//
//  FunnyViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/16.
//  Copyright © 2018 ChrisYoung. All rights reserved.
// 繼承BaseAnchorViewController 就自動會有個UICollectionView
// 如果崩了就是還沒把baseVM給賦值

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    
    // MARK:- 懶加載屬性

    // MARK:- 系統回調
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
}

// MARK:- 設置UI介面
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        // 不要headerView 所以要改寫size
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        // 設置collectionView的內邊距
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
}

// MARK:- 請求數據後展示
extension FunnyViewController {
    override func loadData() {
        
    }
}
