//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/30.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    
    // MARK:- 控件屬性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: 定義模型屬性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    // MARK:- 系統回調函數
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
