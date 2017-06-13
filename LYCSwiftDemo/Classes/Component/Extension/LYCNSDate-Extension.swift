//
//  LYCNSDate-Extension.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

extension Date {
    func getCurrentDate() -> String {
        let nowDate = Date()
        let timeInterval = nowDate.timeIntervalSince1970
        return "\(timeInterval)"
    }
}
