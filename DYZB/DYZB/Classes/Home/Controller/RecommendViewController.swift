//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/12.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//  因為推薦介面和遊戲介面有很多相同的代碼所以要進行抽取成父類別

import UIKit

//private let kItemMargin : CGFloat = 10
//private let kItemW = (kScreenW - 3 * kItemMargin) / 2
//private let kNormalItemH = kItemW * 3 / 4
//private let kPrettyItemH = kItemW * 4 / 3
//private let kHeaderViewH : CGFloat = 50 //組頭讓cell看起來來沒有連在一起

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90


//private let kNormalCellID = "kNormalCellID"
//private let kPrettyCellID = "kPrettyCellID"
//private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: BaseAnchorViewController {
    
    // MARK:- 懶加載屬性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //加到collectionView裡才可以滾動
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //懶加載gameView
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
    //        // 1.創建布局
    //        let layout = UICollectionViewFlowLayout() //流水布局
    //        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
    //        layout.minimumLineSpacing = 0
    //        layout.minimumInteritemSpacing = kItemMargin
    //        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
    //        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin) //設定間距 這這樣才才會左中右三個10
    //
    // 2.創建UICollectionView
    
    //        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    //        collectionView.backgroundColor = UIColor.white
    //        collectionView.dataSource = self
    //        collectionView.delegate = self
    //        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //自動調整與superView的Height，Width
    //
    //        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
    //        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
    //        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
    //        return collectionView
    //        }()
    
    //    // MARK:- 系統回調
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        // 設置UI界面
    //        setupUI()
    //
    //        //發送網路請求
    //        loadData()
    //    }
    
}


// MARK:- 設置UI界面内容
extension RecommendViewController {
    
    override func setupUI() {
        
        // 1.先調用super.setupUI()
        super.setupUI()
        
        // 1.將UICollectionView添加到控制器的View中
        //        view.addSubview(collectionView)
        
        // 2.將CycleView添加到控制器的UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.將gameView添加到控制器的UICollectionView中
        collectionView.addSubview(gameView)
        
        // 4. 設置collectionView的內邊距 才會讓輪播View直接顯示出來
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH , left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 請求數據
extension RecommendViewController {
    
    override func loadData() { //24.12.30這裡沒有循迴引用
        // 0.給父類中的viewModel進行賦值
        baseVM = recommendVM
        
        // 1.請求推薦數據
        recommendVM.requestData{
            // 1.展示推薦數據
            self.collectionView.reloadData()
            
            // 2.將數據傳遞给GameView
//            self.gameView.groups = self.recommendVM.anchorGroups
            var groups = self.recommendVM.anchorGroups
            
            // 2.1 刪除前兩組
            groups.removeFirst() //熱門
            groups.removeFirst() //顏值
            // 2.2 添加更多組
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        
        // 2.請求無限輪播的數據
        recommendVM.requestCycleData {
            
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}

// MARK:- 遵守UICollectionView的數據源協議
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.設置數據
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            //使用顏值kPrettyItemH高度
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
