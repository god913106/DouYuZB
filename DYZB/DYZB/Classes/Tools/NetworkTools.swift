//
//  NetworkTools.swift
//  DYZB
//
//  Created by 洋蔥胖 on 2018/10/16.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String , parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.獲取類型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.發送網路請求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.獲取結果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 4.將結果回調出去
            finishedCallback(result)
        }
    }
}
