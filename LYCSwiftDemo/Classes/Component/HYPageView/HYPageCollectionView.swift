//
//  HYPageCollectionView.swift
//  pageView扩展
//
//  Created by 李玉臣 on 2017/6/11.
//  Copyright © 2017年 yuchen.li. All rights reserved.
//

import UIKit
private let kCellId = "kCellId"


protocol HYPageCollectionViewDataSource : class{
    func numberOfSections(pageCollectionView : HYPageCollectionView ) -> Int
    func collection(_ pageCollectionView : HYPageCollectionView , numberOfItemsInSection section : Int) -> Int
    func collection(_ pageCollectionView : HYPageCollectionView , collectionView : UICollectionView , cellForItemAt indexPath : IndexPath) ->UICollectionViewCell
}

protocol HYPageCollectionViewDelegate : class {
    func collection(_ pageCollectionView : HYPageCollectionView , collection : UICollectionView , didSelectItemAtIndexPath indexPath : IndexPath)
}

class HYPageCollectionView: UIView {
    weak var datasoure : HYPageCollectionViewDataSource?
    weak var delegate  : HYPageCollectionViewDelegate?
    
    
    var isPageEnable : Bool = true
    var showsHorizontalScrollIndicator : Bool = false
    // 若 lazy 修饰属性 ,则 该属性不可以在 初始化之前用 self 来调用
    fileprivate var titles : [String] = []
    fileprivate var style  : HYTitleStyle!
    
    fileprivate var isTitleInTop : Bool
    fileprivate var layout : HYPageCollectionFlowLayout!
    fileprivate var collectionView : UICollectionView!
    fileprivate var titleView : HYTitleView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var sourceSection : Int = 0

    
    init(frame: CGRect , titles : [String] , style : HYTitleStyle , isTitleInTop : Bool , layout : HYPageCollectionFlowLayout) {
        
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        self.style = style
        
        
        super.init(frame: frame)
        setupUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HYPageCollectionView {
    func setupUI(){
        let titleViewY = self.isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        titleView = HYTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.backgroundColor = style.titleBackgroundColor
        titleView.delegate = self
        addSubview(titleView)
        
        let pageControlY = self.isTitleInTop ? bounds.height - 10 : titleView.frame.minY - 10
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: 10)
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        addSubview(pageControl)
        
        let collectionY = self.isTitleInTop ? titleViewFrame.maxY : 0
        let collectionFrame = CGRect(x: 0, y: collectionY, width: bounds.width, height: bounds.height - 10 - titleView.bounds.height)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = isPageEnable
        collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        addSubview(collectionView)
        
    
    }


}
// MARK:-对外暴露的方法
extension HYPageCollectionView{
    func register(nib : UINib , identifier : String){
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func register(cell : AnyClass? , identifier : String){
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }

}
// MARK:- UICollectionViewDataSource
extension HYPageCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (datasoure?.numberOfSections(pageCollectionView: self)) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let number = datasoure?.collection( self, numberOfItemsInSection: section) ?? 0
        // 设置pageControl的初始pageNumber 
        if section == 0 {
            let page = (number - 1) / (layout.rows * layout.cols) + 1
            pageControl.numberOfPages = page
        }
     
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return (datasoure?.collection(self, collectionView: collectionView, cellForItemAt: indexPath))!
    }

}
// MARK:- UICollectionViewDelegate
extension HYPageCollectionView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collection(self, collection: collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }
    
    func  scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 速度为0
        if !decelerate {
            scrollEndScroll()
        }
    }
    
    private func scrollEndScroll(){
        let point = CGPoint(x: collectionView.contentOffset.x + layout.sectionInset.left , y: layout.sectionInset.top)
        // 获取当前页 第一个cell的indexPath
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            print("找不到对应的IndexPath")
            return
        }
        let section = indexPath.section
        let itemCount = collectionView.numberOfItems(inSection: section)
        let pageNumber = (itemCount - 1) / (layout.rows * layout.cols) + 1
        let item = indexPath.item
        let pageIndex = item  / (layout.rows * layout.cols)
        // 改变PageControl的状态
        changePageControlStatus(pageNumber: pageNumber, currentPage: pageIndex)
        // 改变 titleView 的状态
        
        titleView.setTitleWithProgress(1, sourceIndex: sourceSection, targetIndex: section)
        // 改变当前状态
        sourceSection = section
        
    }
    
    fileprivate func changePageControlStatus(pageNumber : Int , currentPage : Int ){
        pageControl.numberOfPages = pageNumber
        pageControl.currentPage = currentPage
    }
    
    
    
}

extension HYPageCollectionView : HYTitleViewDelegate {
    func titleView(_ titleView: HYTitleView, selectedIndex index: Int) {
        let sectionCount = collectionView.numberOfSections
        if (index <= sectionCount){
            let indexPath = IndexPath(item: 0, section: index)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            let itemCount = collectionView.numberOfItems(inSection: index)
            let pageNumber = (itemCount - 1) / (layout.rows * layout.cols) + 1
            changePageControlStatus(pageNumber: pageNumber, currentPage: 0)
        }
        
    }

}
