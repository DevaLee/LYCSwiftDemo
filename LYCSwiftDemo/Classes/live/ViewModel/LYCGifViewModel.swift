//
//  LYCGifViewModel.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/13.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

private let urlString = "http://qf.56.com/pay/v4/giftList.ios"

class LYCGifViewModel: NSObject {
    static var shareInstance : LYCGifViewModel = LYCGifViewModel()
    
    var gifPackage : [LYCGifModel] = []
    override init (){
    
    
    }
    
    init(array : Array<[String : Any]>) {
        for dict in array {
            gifPackage.append(LYCGifModel(dict: dict))
        }
    }
}

extension LYCGifViewModel {

    func loadGifData(finishCallBack : @escaping () -> ()){
        
        LYCNetworkTool.loadData(type: .GET, urlString: urlString, parameter: ["type" : 0,"page" : 1 , "rows" : 150]) { (response) in
            guard let responseResult = response as? [String : Any] else{
                print("数据出错")
                return
            }
            
            guard let type1Dict = responseResult["message"] as? [String : Any] else{
                print("数据出错 message")
                return
            }
            
            guard let listDict = type1Dict["type1"] as? [String : Any] else{
                print("数据出错 list")
                return
            }
            
            guard let listArray = listDict["list"] as? [[String : Any]] else{
                print("数据出错 Array")
                return
            }
            
            for gifDict in listArray{
                self.gifPackage.append(LYCGifModel(dict : gifDict))
            }

            finishCallBack()
        }
    
    }

}
