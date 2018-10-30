//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/15.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    // MARK:- 控件屬性
    @IBOutlet weak var cityBtn: UIButton!
    
    
    
    // MARK:- 定義模型屬性
    override  var anchor : AnchorModel? {
        didSet {
            // 1.將屬性傳遞給父類
            super.anchor = anchor
            
            
            
            // 3.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
            
            
        }
    }
    
}
