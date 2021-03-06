//
//  PageTitleView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/8.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

// MARK:- 定義協議
protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

//MARK:- 定義常數
private let kScrollLineH: CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85) //灰色
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0) //橘色

//MARK:- 定義PageTitleView類
class PageTitleView: UIView {
    
    //MARK:- 定義屬性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懶加載屬性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK:- 自定義構造函數
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 設置UI介面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 設置UI介面
extension PageTitleView {
    fileprivate func setupUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title對應的Label
        setupTitleLabels()
        
        // 3.設置底線和滾動的滑塊
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        
        // 0. 確定label的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.創建UILabel
            let label = UILabel()
            
            // 2.設置Label的屬性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.設置Label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.把label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.給Label添加手勢
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        // 1.添加底線
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH :CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.獲取第一個Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2.設置scrollLine的屬性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


//MARK:- 監聽Label的點擊
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        // 0.獲取當前的Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果是重復點擊同一個Title,那麼直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.獲取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切換文字的顏色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4.保存最新 Label 的下標值
        currentIndex = currentLabel.tag
        
        // 5.滾動條位置發生改變
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK:- 對外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.處理滑塊的邏輯
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.顏色的漸變(複雜)
        // 3.1.取出變化的範圍
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.變化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.變化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.記錄最新的index
        currentIndex = targetIndex
    }
}
