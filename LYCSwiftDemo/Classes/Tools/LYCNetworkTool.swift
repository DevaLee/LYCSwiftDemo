//
//  LYCNetworkTool.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class LYCNetworkTool {
    /* 请求数据*/
    class func  loadData(type : MethodType , urlString : String ,parameter : [String : Any]? = nil , finishCallBack : @escaping (_ result : Any) ->()) {
        let methodType = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: methodType, parameters: parameter).validate(contentType: ["text/plain" , "application/json"]).responseJSON { (response) in

            guard let result = response.result.value else{
                print("数据请求失败",urlString)
                return
            }
            finishCallBack (result)
        }
    }
}
