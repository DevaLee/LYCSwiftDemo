//
//  LYCBaseModel.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCBaseModel: NSObject {
    override init() {
        
    }
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
