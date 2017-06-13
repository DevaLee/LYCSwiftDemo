//
//  LYCSharedViewController.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/7.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCSharedViewController: NSObject {

  
    
    func mainViewController() -> (UIViewController) {
        let mainVC = LYCMainViewController()
        return mainVC
    }
    
    func discorverViewController() -> (UIViewController) {
        return LYCDiscorverViewController()
    }
    
    func meViewController() -> (UIViewController) {
        return LYCMeViewController()
    }
    
    func rankViewController() -> (UIViewController) {
        return LYCRankViewController()
    }

}
