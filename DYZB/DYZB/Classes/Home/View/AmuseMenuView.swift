//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/14.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    // MARK:- 定義屬性
    var groups : [AnchorGroup]?
        {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    // MARK:- 控件屬性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK:- 從xib中加載出來
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //註冊cell
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    /*
     讓兩個原本很小的cell 可以變成整個collectionView的bounds那麼大
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}


// MARK:- 通過xib快速建立類方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK:- AmuseMenuView的數據源
/*
 娛樂頂部介面是由外層collectionView先做出兩個cell，再這兩個cell中各放入一個collectionView來展示數據
 */
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        pageControl.numberOfPages = 2
//                return 2 //原本寫死2頁
        
        //現在要讓他計算有幾頁 一頁有8個group.count
        //將每一頁的數據傳遞給amuseViewCell
        if groups == nil {

            return 0
        }
        let pageNum = (groups!.count - 1) / 8 + 1 //因為先判斷如果nil就返回 所以會到這就是一定有值用!來打開
        pageControl.numberOfPages = pageNum

        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
        // 2.給cell設置數據
//        cell.backgroundColor = UIColor.randomColor()
        //如何從groups多個數據裡取出對應當前頁面的數據，再傳給這頁的cell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        // 0頁: 0 ~ 7
        // 1頁: 8 ~ 15
        // 2頁: 16 ~ 23
        // 1.取出起始位置&终點位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判斷越界問題 endIndex越界過groups!.count - 1(最後一個) 就讓endIndex = (最後一個)
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出數據,再賦值给cell
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
}

// MARK:- AmuseMenuView的代理源
extension AmuseMenuView : UICollectionViewDelegate {
    //讓pageControl跟著滾動
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
