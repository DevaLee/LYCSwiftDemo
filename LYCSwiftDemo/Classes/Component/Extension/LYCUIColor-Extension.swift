//
//  LYCUIColor-Extension.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/8.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

extension UIColor{

    convenience public  init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
       self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor{
        return UIColor(r : CGFloat(arc4random_uniform(256)), g : CGFloat(arc4random_uniform(256)), b : CGFloat(arc4random_uniform(256)))
    }
    
    class func themeColor() -> UIColor {
        return UIColor(r: 216.0, g: 164, b: 78)
    }

}
