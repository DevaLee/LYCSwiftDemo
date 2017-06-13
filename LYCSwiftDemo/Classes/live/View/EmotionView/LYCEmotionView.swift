//
//  LYCEmotionView.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/12.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

private let kCellId = "kCellId"
private let kCellName = "LYCEmotionCollectionViewCell"

protocol LYCEmotionViewDelgate : class  {
    func didSelectEmotion(emotion : LYCEmotionModel)
}

class LYCEmotionView: UIView {
    
    weak var delegate : LYCEmotionViewDelgate?
    
    var emotionClickCallBack : ((LYCEmotionModel) -> ())?
    
    
    fileprivate var emotionView : HYPageCollectionView!
    fileprivate lazy var emotionVM   : LYCEmotionViewModel = LYCEmotionViewModel()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LYCEmotionView {
    fileprivate func setupUI(){
        
        let titles = ["热门","专属"]
        let style  = HYTitleStyle()
        let layout = HYPageCollectionFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.cols = 7
        layout.rows = 3
        
        let emoFrame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        emotionView = HYPageCollectionView(frame: emoFrame, titles: titles, style: style, isTitleInTop: false, layout: layout)
        emotionView.datasoure = self
        emotionView.delegate  = self
        emotionView.backgroundColor = UIColor.black
        //MARK:???出错
        // NSStringFromClass(LYCEmotionCollectionViewCell.self)
        let nib = UINib.init(nibName: kCellName, bundle: nil)
        emotionView.register(nib: nib, identifier: kCellId)
        addSubview(emotionView)
    }
}
//MARK:- 数据源
extension LYCEmotionView : HYPageCollectionViewDataSource {
    
    func numberOfSections(pageCollectionView: HYPageCollectionView) -> Int {
        return emotionVM.package.count
    }
    
    func collection(_ pageCollectionView: HYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = emotionVM.package[section]
        return package.emotionPack.count
    }
    
    func collection(_ pageCollectionView: HYPageCollectionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! LYCEmotionCollectionViewCell
        let emotionPack = emotionVM.package[indexPath.section] as LYCEmotionPackage
        let emotionModel = emotionPack.emotionPack[indexPath.item]
        cell.emotionModel = emotionModel
        return cell
    }

}
//MARK:- 代理方法
extension LYCEmotionView : HYPageCollectionViewDelegate {
    func collection(_ pageCollectionView: HYPageCollectionView, collection: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        let emotionModel =  emotionVM.package[indexPath.section].emotionPack[indexPath.item]
       // delegate?.didSelectEmotion(emotion: emotionModel)
        
        if let callBack = emotionClickCallBack {
            callBack(emotionModel)
        }
    }

}
