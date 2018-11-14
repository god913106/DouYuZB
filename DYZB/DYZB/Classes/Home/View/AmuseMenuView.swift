//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/11/14.
//  Copyright © 2018 ChrisYoung. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {

}

//通過xib快速建立類方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
