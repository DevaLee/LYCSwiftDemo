//
//  LYCEmotionViewModel.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/12.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCEmotionViewModel: NSObject {
    static var shareInstance : LYCEmotionViewModel = LYCEmotionViewModel()
    // 表情的数据源
    lazy var  package : [LYCEmotionPackage] = []
    
    override init() {
        super.init()
        package.append(LYCEmotionPackage.init(fileName: "QHNormalEmotionSort.plist"))
        package.append(LYCEmotionPackage.init(fileName: "QHSohuGifSort.plist"))
    }
}
