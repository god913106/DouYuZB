//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/13.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50 //組頭讓cell看起來來沒有連在一起

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class AmuseViewController: UIViewController {

    // MARK:- 懶加載屬性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.創建布局
        let layout = UICollectionViewFlowLayout() //流水布局
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin) //設定間距 這這樣才才會左中右三個10
        
        // 2.創建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //自動調整與superView的Height，Width
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
        }()
        
    // MARK:- 系統回調
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
}

// MARK:- 設置UI介面
extension AmuseViewController {
    fileprivate func setupUI() {
        // 1.添加UICollectionView
        view.addSubview(collectionView)
        
        // 2.添加頂部的HeaderView
//        collectionView.addSubview(topHeaderView)
        
        // 3.將常用遊戲的view，添加到collectionView中
//        collectionView.addSubview(gameView)
        
        // 設置collectionView的內邊距
//        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        
    }
}


// MARK:- 遵守UICollectionView的數據源協議
extension AmuseViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    // 8個群組
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    // 群組裡有4個item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // 反回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        // 2.給cell設置數據
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    
}
