//
//  LYCEmotionPackage.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/12.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

// 单个 section
class LYCEmotionPackage: NSObject {
    var emotionPack : [LYCEmotionModel] = []
    
    init(fileName : String ) {
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil)  else {
            print("获取文件出错")
            return
        }

        guard let emotionArray = NSArray(contentsOfFile: filePath) as? [String] else {
            print("数据类型错误")
            return
        }
        // 单个section里面的表情
        for emotiName  in emotionArray {
            emotionPack.append(LYCEmotionModel(emotionName: emotiName))
        }
    }
    

}
