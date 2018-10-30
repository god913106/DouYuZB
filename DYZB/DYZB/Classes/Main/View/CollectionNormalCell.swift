//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/15.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    // MARK:- 控件屬性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    // MARK:- 定義模型屬性
   override var anchor : AnchorModel?{
        didSet {
            // 1.將屬性傳遞給父類
            super.anchor = anchor

            
            
            // 4.房間名稱
            roomNameLabel.text = anchor?.room_name
        }
        
    }
}
