//
//  LYCAnchorViewController.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

private let kMargin : CGFloat = 8
private let kAnchorCellId : String = "kAnchorCellId"

class LYCAnchorViewController: UIViewController {
    //对外属性
    var mainTypeModel : LYCMainTypeModel!
    //对内属性
    fileprivate lazy var mainVM : LYCMainViewModel = LYCMainViewModel()
    fileprivate lazy var collectionView : UICollectionView = {
        // 创建瀑布流布局
        let waterFullLayout = LYCCollectionViewLayout()
        waterFullLayout.minimumLineSpacing = kMargin
        waterFullLayout.minimumInteritemSpacing = kMargin
        waterFullLayout.sectionInset = UIEdgeInsets(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
        waterFullLayout.dataSource = self as LYCWaterfallLayoutDataSource
        // 创建 collectionView
        let collectionView = UICollectionView(frame: self.view.bounds , collectionViewLayout: waterFullLayout)
        collectionView .register(UINib.init(nibName: "LYCAnchorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kAnchorCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(mainTypeModel.type, index: 0)
    }
   
   
}

// MARK:- 1,初始化UI 2,加载数据
extension LYCAnchorViewController{
    // 初始化UI
    fileprivate func setupUI(){
        
        self.view.addSubview(collectionView)
    
    }
    // 加载数据
    fileprivate func loadData(_ type : Int , index : Int){
        
        mainVM.loadMainData(methodType: .GET, urlString: "http://qf.56.com/home/v4/moreAnchor.ios", parameter: ["type" : type, "index" : index , "size" : 48]) {
                self.collectionView.reloadData()
        }
    }

}
// MARK:- 瀑布流布局的代理方法
extension LYCAnchorViewController : LYCWaterfallLayoutDataSource{
    func numberOfColsInWaterfallLayout(_ layout: LYCCollectionViewLayout) -> Int {
        return 2
     
    }
    
    func waterfallLayout(_ layout: LYCCollectionViewLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? kScreenWidth * 2 / 3.0 : kScreenWidth  * 0.5
    }
}
// MARK:- collectionView 的数据源
extension LYCAnchorViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
         return mainVM.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: kAnchorCellId, for: indexPath) as! LYCAnchorCollectionViewCell
      
        collectionViewCell.anchorModel = mainVM.anchors[indexPath.item]
        // 上拉刷新
        if indexPath.item == mainVM.anchors.count - 1 {
            loadData(mainTypeModel.type, index: mainVM.anchors.count)
        }
        return collectionViewCell
    }
}

extension LYCAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = LYCRoomViewController()
        self.navigationController?.pushViewController(roomVc, animated:true)
        
    }

}

