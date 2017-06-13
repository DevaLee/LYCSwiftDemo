//
//  HYPageCollectionFlowLayout.swift
//  pageView扩展
//
//  Created by 李玉臣 on 2017/6/11.
//  Copyright © 2017年 yuchen.li. All rights reserved.
//

import UIKit

class HYPageCollectionFlowLayout: UICollectionViewFlowLayout {
    var cols : Int = 1
    var rows : Int = 1
    
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = []
    fileprivate lazy var maxWidth : CGFloat = 0

}
extension HYPageCollectionFlowLayout{
    override func prepare() {
        
        let itemW = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - minimumLineSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        
        let itemH = (collectionView!.bounds.size.height - sectionInset.top - sectionInset.bottom - minimumInteritemSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        // 一共有多少组
        let sectionNum = collectionView!.numberOfSections
        // 前面一共有多少页
        var prePageCount : Int = 0

        for i in 0 ..< sectionNum {
            let itemCount  = collectionView?.numberOfItems(inSection: i)
    
            for j in 0 ..< collectionView!.numberOfItems(inSection: i) {
                // 取出对应的indexPath
                let indexPath = IndexPath(item: j, section: i)
                // 根据IndexPath 创建 Attribute
                let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                // 设置 layoutAttribute 的frame
                
                //计算 j 在该section 中第几页 在该页中的index
                let page  = Int(j / (cols * rows) )
                let index = Int( j % Int (cols * rows))
                
                var itemY : CGFloat = 0
                var itemX : CGFloat = 0
                
                itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat((index / cols))
                itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat (index % cols)
                
                layoutAttribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                cellAttrs.append(layoutAttribute)
            }
            prePageCount += (itemCount! - 1) / (rows * cols) + 1
        }
        self.maxWidth = CGFloat(prePageCount) * (collectionView?.bounds.width)!
    }


}

extension HYPageCollectionFlowLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }

}

extension HYPageCollectionFlowLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: self.maxWidth, height: 0)
    }

}
