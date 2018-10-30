//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/25.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    // MARK:- 控件屬性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    
    
    // MARK:- 定義模型屬性
    var anchor : AnchorModel? {
        didSet {
            
            // 0.校驗模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在線人數顯示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))萬在線"
            }else {
                onlineStr = "\(anchor.online)在線"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.nickName
            nickNameLabel.text = anchor.nickname
            
            // 3.設置封面圖片
            guard let url = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: url)
            
            
            
        }
        
    }
}
