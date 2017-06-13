//
//  LYCMainViewController.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/7.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCMainViewController: UIViewController {

    var searchBar : UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

}

// MARK: - 设置导航
extension LYCMainViewController{
    //使用 fileprivate 来暴露内部接口, 用 private 来进行内部实现
    // MARK:  接口
    fileprivate func setupUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        setupChildVCs()
    
    }
    // MARK:  实现   设置导航条
    private func setupNavigationBar() {
        // 左边按钮
        let logoImage = UIImage(named : "")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:logoImage , style: .plain, target: self , action : nil)
        // 右边按钮
        let rightImage = UIImage(named : "search_btn_follow")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (image:rightImage , style: .plain, target: self , action : #selector (folloeItemClick))
        // 中间搜索框
        let searchFrame = CGRect(x:0,y:0,width:200,height:32)
        searchBar = UISearchBar(frame: searchFrame)
        searchBar!.placeholder = "站点,链接"
        searchBar?.searchBarStyle = .minimal
        self.navigationItem.titleView = searchBar;
        
        
        let searchFiled = searchBar?.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.green
    }
    // 添加 AnchorVC 子控制器
    private func setupChildVCs(){
        
        let homeTypeArray = loadData()
        let titles = homeTypeArray.map { (mainTypeModel : LYCMainTypeModel) -> String in
            return  mainTypeModel.title
        }
        var childVCs = [LYCAnchorViewController]()
        for mainType in homeTypeArray {
            let anchorVc = LYCAnchorViewController ()
            anchorVc.mainTypeModel = mainType
            childVCs .append(anchorVc)
        }
        let titleStyle = HYTitleStyle.init()
        titleStyle.isScrollEnable = true
        titleStyle.isShowBottomLine = true
        titleStyle.normalColor = UIColor(r: 255, g: 255, b: 255)
        let pageViewFrame = CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight)
        // 将 子控制器 加到 父控制器中 ，将子控制器的view 作为父控制器中 cell的子view
        let pageView = HYPageView.init(frame: pageViewFrame, titles: titles, style: titleStyle, childVcs: childVCs, parentVc: self)
        
        self.view.addSubview(pageView)
    }
    
    fileprivate func loadData() -> [LYCMainTypeModel]{
        let path = Bundle.main.path(forResource: "types.plist", ofType: "")
        let dataArray = NSArray(contentsOfFile: path!)
        var mainTypeArray = [LYCMainTypeModel]()
        for dict in dataArray! {
            let mainModel = LYCMainTypeModel(dict :dict as! [String : Any])
            mainTypeArray.append(mainModel)
        }
        return mainTypeArray
    }
}
// MARK: - 监听
extension LYCMainViewController{
     // @objc - http://www.csdn.net/article/2015-02-04/2823831-swift-objc-and-dynamic
    //  需要暴露给Objective-C使用的任何地方（包括类，属性和方法等）的声明前面加上@objc修饰符。注意这个步骤只需要对那些不是继承自NSObject的类型进行，如果你用Swift写的class是继承自NSObject的话，Swift会默认自动为所有的非private的类和成员加上@objc。这就是说，对一个NSObject的子类，你只需要导入相应的头文件就可以在Objective-C里使用这个类了  (在 OC 中 可以映射到这个方法)
    @objc fileprivate func folloeItemClick(){
        
        searchBar?.resignFirstResponder()
       
    }
}
