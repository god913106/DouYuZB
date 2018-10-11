//
//  PageContentView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/8.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK:- 定義屬性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false  //禁止滾動代理方法 默認不禁止
    weak var delegate : PageContentViewDelegate?
    
    //MARK:- 懶加載屬性
    private lazy var collectionView : UICollectionView = { [weak self] in
        // 1.創建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.創建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //水平方向指示器
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK:- 自定義構造函數
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //設置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 設置UI介面
extension PageContentView {
    private func setupUI() {
        // 1.把所有的子控制器添加父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        // 2.添加UICollectionView，用在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.創建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.設置Cell內容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()  //因為循環利用會添加加多次 最好是把我們之前的移除 再添加新的
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false //一旦開始滾動的話 就默認不禁止滾動
 
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判斷是是否點擊事件
        if isForbidScrollDelegate { return }
        
        // 1.定義獲取需要的數據
        var progress : CGFloat = 0 //滾動的進度
        var sourceIndex : Int = 0 //當前位子的index
        var targetIndex : Int = 0 //左滑右滑後的目標index
        
        // 2.判斷左滑還是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {// 左滑
            // 1.計算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.計算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.計算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全滑過去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.計算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.計算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.計算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3.將progress/sourceIndex/targetIndex傳遞给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


//MARK:- 對外暴露的方法
extension PageContentView {
    func setCurrentIndex (currentIndex : Int) {
        
        // 1.記錄需要禁止執行代理方法
        isForbidScrollDelegate = true
        
        // 2.滾動正確的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
