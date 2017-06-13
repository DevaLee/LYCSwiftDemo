//
//  LYCMainViewModel.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCMainViewModel: NSObject {
    var anchors : [LYCAnchorTypeModel] = []
}

extension LYCMainViewModel {
    func loadMainData(methodType : MethodType , urlString : String , parameter : [String : Any]? , finishCallBack : @escaping()->() ){
        LYCNetworkTool.loadData(type: methodType, urlString: urlString, parameter: parameter) { (result : Any) -> Void in
            // 确保 result 为字典形式
            guard let resultDict = result as? [String : Any] else{
                return
            }
            guard  let messageDict = resultDict["message"] as? [String : Any] else {
                return
            }
            // 确保 dataArray 为存放字典的数组
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else{
                return
            }
            
            for(i , anchorDict) in dataArray.enumerated() {
                let anchorModel = LYCAnchorTypeModel.init(dict : anchorDict)
                anchorModel.isEvenIndex = i % 2 == 0
                self.anchors.append(anchorModel)
            }
            finishCallBack()
        }
    }
    
}
