//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/30.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {
    
    // MARK:- 控件屬性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK:- 系統回調函數
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //23.11.00
        //設置該控件不隨著父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        //註冊Cell
//        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
                collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
    
}


// MARK:- UICollectionView Delegate
extension RecommendGameView : UICollectionViewDelegate {
    
}
