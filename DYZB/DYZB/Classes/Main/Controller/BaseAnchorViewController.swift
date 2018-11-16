//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/13.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//  baseViewController是先從娛樂介面抽取成父類別 再去把推薦介面也繼承自baseViewController
//  如果崩了就是還沒把baseVM給賦值 所以還是做個檢查 如果baseVM是nil 就返回1個組  1個組裡有20條數據

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50 //組頭讓cell看起來來沒有連在一起

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
let kPrettyCellID = "kPrettyCellID"

class BaseAnchorViewController: UIViewController {
    
    // MARK:-定義屬性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.創建布局
        let layout = UICollectionViewFlowLayout() //流水布局
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
        loadData()
    }
}

// MARK:- 設置UI介面
extension BaseAnchorViewController {
    @objc func setupUI() {
        // 1.添加UICollectionView
        view.addSubview(collectionView)
    }
}

// MARK:- 請求數據後展示
extension BaseAnchorViewController {
    @objc func loadData() {
        
    }
}


// MARK:- 遵守UICollectionView的數據源協議
extension BaseAnchorViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    // 8個群組
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            return baseVM.anchorGroups.count
        
        //        return 8
        
    }
    
    // 群組裡有4個item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return 4
        
            return baseVM.anchorGroups[section].anchors.count
    }
    
    // 反回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        
            // 2.給cell設置數據
            cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
    }
    
    // headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
            // 2.给HeaderView設置數據
            headerView.group = baseVM.anchorGroups[indexPath.section]
            
            return headerView
    }
}

// MARK:- 遵守UICollectionView的代理協議
//extension BaseAnchorViewController : UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 1.取出对应的主播信息
//        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//
//        // 2.判断是秀场房间&普通房间
//        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
//    }
//
//    private func presentShowRoomVc() {
//        // 1.创建ShowRoomVc
//        let showRoomVc = RoomShowViewController()
//
//        // 2.以Modal方式弹出
//        present(showRoomVc, animated: true, completion: nil)
//    }
//
//    private func pushNormalRoomVc() {
//        // 1.创建NormalRoomVc
//        let normalRoomVc = RoomNormalViewController()
//        
//        // 2.以Push方式弹出
//        navigationController?.pushViewController(normalRoomVc, animated: true)
//    }
//}
