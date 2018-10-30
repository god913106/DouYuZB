//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/26.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    // MARK:- 定義屬性
    @objc var cycleModels : [CycleModel]? {
        didSet{
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.設置pageControl個數
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:- 控件屬性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK:- 系統回調函數
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //23.11.00
        //設置該控件不隨著父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        //註冊Cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //設置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
    }
}

// MARK:- 提供一個快速創建View的類方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK:- UICollectionView DataSource
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
    
    
}
