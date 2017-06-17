//
//  LYCGifView.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/13.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

private let kGifCellId = "kGifCellId"
@objc protocol LYCGifViewDelegate :NSObjectProtocol {
    @objc optional func gitView(_ gifView : LYCGifView ,collectionView : UICollectionView , didSelectRowAtIndex  indexPath : IndexPath , gifModel : LYCGifModel)
}

class LYCGifView: UIView {
    weak var deleage : LYCGifViewDelegate?
    
    fileprivate lazy var gifCollectionView : HYPageCollectionView =  {
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: 280)
        let titles = ["礼物"]
        let style = HYTitleStyle()
        style.isShowBottomLine = false
        style.titleBackgroundColor = UIColor.black
        let layout = HYPageCollectionFlowLayout()
        layout.cols = 4
        layout.rows = 2
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let gifView = HYPageCollectionView(frame: rect, titles:titles , style: style, isTitleInTop: false, layout: layout)
        let nib = UINib(nibName: "LYCGifViewCell", bundle: nil)
        gifView.register(nib: nib , identifier: kGifCellId)
        gifView.datasoure = self
        gifView.delegate = self
        return gifView
    }()
    fileprivate lazy var gifVM   : LYCGifViewModel = LYCGifViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
//MARK:-初始化UI
extension LYCGifView {
    
    func setupUI(){
        addSubview(gifCollectionView)
    }

}

//MARK:- 数据源方法
extension LYCGifView : HYPageCollectionViewDataSource{
    
    func numberOfSections(pageCollectionView: HYPageCollectionView) -> Int {
        return 1
    }
    
    func collection(_ pageCollectionView: HYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return LYCGifViewModel.shareInstance.gifPackage.count
    }
    
    func collection(_ pageCollectionView: HYPageCollectionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kGifCellId, for: indexPath) as! LYCGifViewCell
        let gifModel = LYCGifViewModel.shareInstance.gifPackage[indexPath.row]
        cell.gifModel = gifModel
        
        return cell
    }
}
//MARK:- 代理方法
extension LYCGifView : HYPageCollectionViewDelegate{
    
    func collection(_ pageCollectionView: HYPageCollectionView, collection: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        let gifModel = LYCGifViewModel.shareInstance.gifPackage[indexPath.row]
        deleage?.gitView!(self, collectionView: collection, didSelectRowAtIndex: indexPath, gifModel: gifModel)
    }
}
