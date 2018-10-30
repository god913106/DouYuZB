//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/15.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件屬性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    // MARK:- 定義模型屬性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
