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
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet{
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.設置pageControl個數
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默認滾動到中間某一個位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionView.ScrollPosition.left, animated: false)
            
            // 4.添加定時器
            removeCycleTimer()
            addCycleTimer()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
        Int {
            
            /*
             不會有效能問題的 因為當滑過的cell 就會放進緩衝池裡 進行一個循環利用 當又輪到這個cell時 就會從緩衝池拿出來展示
             */
            return (cycleModels?.count ?? 0) * 10000
            
            
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
         /*
        但調到10000 到時去數組取時 一定會越界 而這個問題要解決就要加上 cycleModels!.count
        */
        return cell
    }
    
    
}

// MARK:- UICollectionView Delegate
extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1.獲取滾動的偏移量
        // + scrollView.bounds.width * 0.5 到一半 就顯示下一個pageControl
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.計算pageControl的currentIndex
        // %(cycleModels?.count ?? 1) 對應item一起連動
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    //當用戶自己手動滾動時 就要把自動滾動給移除掉  
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    //當用戶不再滾動時 就要把自動滾動給加進來
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK:- 對定時器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
