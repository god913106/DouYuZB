//
//  BaseViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/16.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK:-定義屬性
    var contentView : UIView?
    
    // MARK:- 懶加載屬性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin] //autoresizingMask 隨著父控件拉伸而拉伸
        return imageView
        }()
    
    // MARK:- 系統回調
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BaseViewController {
   @objc  func setupUI() {
        // 1.隱藏内容的View
        contentView?.isHidden = true
        
        // 2.添加執行動畫的UIImageView
        view.addSubview(animImageView)
        
        // 3.给animImageView執行動畫
        animImageView.startAnimating()
        
        // 4.設置view的背景顏色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    func loadDataFinished() {
        // 1.停止動畫
        animImageView.stopAnimating()
        
        // 2.隱藏animImageView
        animImageView.isHidden = true
        
        // 3.顯示内容的View
        contentView?.isHidden = false
    }
}
