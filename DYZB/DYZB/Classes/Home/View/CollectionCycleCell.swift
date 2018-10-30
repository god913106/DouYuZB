//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/29.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    
    // MARK: 控件屬性

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: 定義模型屬性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
}
