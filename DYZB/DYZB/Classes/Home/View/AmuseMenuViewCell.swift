//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/14.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    // MARK: 數组模型
    
    
    // MARK: 控件屬性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 從xib中加載出來
    override func awakeFromNib() {
        super.awakeFromNib()
        
         collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
    }

    /*
     讓八個原本小到到靠北的cell 應該是每一行行放四個
     

     */
    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        //間間距10 要改成0  Min Spacing
        layout.minimumInteritemSpacing = 0 // for cell
        layout.minimumLineSpacing = 0      // for line
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
    
}

// MARK:- AmuseMenuView的數據源
/*
 娛樂頂部介面是由外層collectionView先做出兩個cell，再這兩個cell中各放入一個collectionView來展示數據
 */
extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID , for: indexPath) as! CollectionGameCell
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    
}
