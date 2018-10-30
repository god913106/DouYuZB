//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/30.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    // MARK:- 定義屬性
    var groups : [BaseGameModel]? {
        didSet {
            
            // 2.1 刪除前兩組
            groups?.removeFirst()
            groups?.removeFirst()
            // 2.2 添加更多組
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件屬性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK:- 系統回調函數
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //23.11.00
        //設置該控件不隨著父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        //註冊Cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
//                collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView添加内邊距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        
    }
    
}

// MARK:- 提供一個快速創建View的類方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK:- UICollectionView DataSource
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        

        cell.baseGame = groups![(indexPath as NSIndexPath).item]

        return cell
    }
    
    
}


// MARK:- UICollectionView Delegate
extension RecommendGameView : UICollectionViewDelegate {
    
}
