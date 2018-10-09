//
//  PageContentView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/8.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK:- 定義屬性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    
    //MARK:- 懶加載屬性
    private lazy var collectionView : UICollectionView = {
        // 1.創建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.創建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //水平方向指示器
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK:- 自定義構造函數
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
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
            parentViewController.addChild(childVc)
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
