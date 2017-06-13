//
//  LYCAnchorTypeModel.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCAnchorTypeModel : LYCBaseModel {
    var roomid : Int = 0
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0 // 是否在直播
    var push : Int = 0 // 直播显示方式
    var focus : Int = 0 // 关注数
    
    var isEvenIndex : Bool = false  // 确定使用哪种图片
}
