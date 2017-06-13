//
//  LYCNavigationViewController.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/8.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       /*
         Optional(<__NSArrayM 0x6080002492d0>(
         (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fd354f098b0>))
         )
         */
        guard  let targets = interactivePopGestureRecognizer!.value(forKey: "_targets") as? [NSObject] else {
            return
        }
        let targetObj = targets.first
        // 获取target
        let target = targetObj?.value(forKey: "target")
        // 包装 selector
        let targetSelector = Selector(("handleNavigationTransition:"))
        // 将手势添加到导航上面
        let panGesture = UIPanGestureRecognizer.init(target: target, action: targetSelector)
        self.view.addGestureRecognizer(panGesture)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    // 隐藏TabBar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       // self.hidesBottomBarWhenPushed = true
        if viewController .isKind(of: LYCMainViewController.self) || viewController.isKind(of: LYCMeViewController.self) || viewController.isKind(of: LYCRankViewController.self) || viewController.isKind(of: LYCDiscorverViewController.self){
            
        }else{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}

extension LYCNavigationViewController {
    fileprivate func getAllProperty(){
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0 ..< count {
            // 是一个指针
            let nameP  = ivar_getName(ivars![Int(i)])
            let name = String(cString: nameP!)
            print("\(name)")
        }
    }
}
