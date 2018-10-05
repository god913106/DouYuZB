//
//  HomeViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/5.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //設置UI介面
        setupUI()
  }
}
// MARK:- 設置UI介面
extension HomeViewController {
    private func setupUI() {
        //1.設置導航欄
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //1.設置左側的item

        navigationItem.leftBarButtonItem = UIBarButtonItem (imageName: "logo")
        
        //2.設置右側的item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
