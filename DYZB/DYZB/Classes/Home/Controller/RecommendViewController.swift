//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/12.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50 //組頭讓cell看起來來沒有連在一起

private let kCycleViewH = kScreenW * 3 / 8


private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //加到collectionView裡才可以滾動
    fileprivate var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
        
    private lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout() //流水布局
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin) //設定間距 這這樣才才會左中右三個10
        
        // 2.创建UICollectionView
        
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
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        //發送網路請求
        loadData()
    }
    
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    
    private func setupUI() {
        // 1.將UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        // 2.將CycleView添加到控制器的UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3. 設置collectionView的內邊距 才會讓輪播View直接顯示出來
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 請求數據
extension RecommendViewController {
    
    private func loadData() { //24.12.30這裡沒有循迴引用
        // 1.請求推薦數據
        recommendVM.requestData{
            // 1.展示推薦數據
            self.collectionView.reloadData()
        }
        
        // 2.請求無限輪播的數據
        recommendVM.requestCycleData {

            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }

    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    //總共12個群組
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    //每個群組內內有4個item 但第一個群組有8個
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 8
//        }
//
//        return 4
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 0.取出模型對象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 1.定義Cell
        var cell : CollectionBaseCell!
        
        // 2.取出Cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell

        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell

        }
        // 3.將模型賦值給Cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.拿出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]

        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    
}
