//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/5.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //便利構造函數: 1> convenience開頭 2> 在構造函數中必須明確調用一個設計的構造函數(self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        //1.創建UIButton
        let btn = UIButton()
        
        //2.設置btn的圖片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        //3.設置btn的尺寸
        if size == CGSize.zero{
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
            
        //4.創建UIButtonItem
        self.init(customView: btn)
    }
}
