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
    讓兩個原本小到到靠北的cell 可以變成整個collectionView的bounds那麼大   
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
        // 2.給cell設置數據
        cell.backgroundColor = UIColor.randomColor()

        
        return cell
    }
    
    
    
}
