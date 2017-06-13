//
//  LYCNibAbleProtocol.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/11.
//  Copyright © 2017年 zsc. All rights reserved.
//

import Foundation
import UIKit

protocol LYCNibAbleProtocol {
    
}

extension LYCNibAbleProtocol where Self : UIView{
    // 参数是可选的 默认为nil  , 返回值 一定要为Self  
    // 在协议中 类方法 不可以用 class 修饰 要使用 static 修饰
   static func loadNibAble(_ nibName  : String? = nil  ) -> Self {
        let loadName = nibName == nil ? "\(self)" : nibName!
        let nibView = Bundle.main.loadNibNamed(loadName, owner: nibName, options: nil)?.last as! Self
        return nibView
    }

}
