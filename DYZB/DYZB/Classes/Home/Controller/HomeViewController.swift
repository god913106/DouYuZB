//
//  HomeViewController.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/5.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK:- 懶加載屬性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推薦", "游戲", "娛樂", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        // 1.確定內容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.確定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self //這樣contentView滑動時 就會通知給pageTitleView
        return contentView
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設置UI介面
        setupUI()
    }
}
// MARK:- 設置UI介面
extension HomeViewController {
    private func setupUI() {
        // 0. 不需要調整UIScrollView的內邊距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.設置導航欄
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

//MARK:- 遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        //print(index) //拿到這個index後就可以傳給pageContentView讓他做一些設置
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
