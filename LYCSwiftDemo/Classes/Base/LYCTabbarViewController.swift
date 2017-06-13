//
//  LYCTabbarViewController.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/7.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 初始化方法
    func setup() {
        UITabBar.appearance().tintColor = UIColor.white
        
        let mainVC = LYCSharedViewController().mainViewController()
        mainVC.tabBarItem = createTabbarItem(titleString: "首页", imageName: "live-n", selectImageName: "live-p")
        
       addChildVC(childVC: mainVC)
        
       // let ranking-p
        let rankingVC = LYCSharedViewController().rankViewController()
        rankingVC.tabBarItem = createTabbarItem(titleString: "排行", imageName: "ranking-n", selectImageName: "ranking-p")
        addChildVC(childVC: rankingVC)
    
        
        let discorverVC = LYCSharedViewController().discorverViewController()
        discorverVC.tabBarItem = createTabbarItem(titleString: "发现", imageName: "found-n", selectImageName: "found-p")
        addChildVC(childVC: discorverVC)

        
        let meVC = LYCSharedViewController().meViewController()
        meVC.tabBarItem = createTabbarItem(titleString: "我", imageName: "mine-n", selectImageName: "mine-p")
        addChildVC(childVC: meVC)
        self.selectedIndex = 0
        
    }
    // 创建Item
    func createTabbarItem(titleString : String ,imageName : String, selectImageName : String) -> (UITabBarItem) {
        let preimage = UIImage(named : imageName)?.withRenderingMode(.alwaysOriginal)
        let selectImage = UIImage(named : selectImageName)?.withRenderingMode(.alwaysOriginal)
        let barItem    = UITabBarItem.init(title: titleString, image: preimage, selectedImage: selectImage)
        
        barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.init(r: 191, g: 138, b: 82)], for: .selected)
        barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: .normal)
        return barItem;
    }
    // 添加 子控制器
    func addChildVC(childVC : UIViewController){
        let nav = LYCNavigationViewController.init(rootViewController: childVC)
        self.addChildViewController(nav)
        
    }
}
