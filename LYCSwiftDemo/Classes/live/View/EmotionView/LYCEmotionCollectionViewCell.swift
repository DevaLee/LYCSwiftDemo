//
//  LYCEmotionCollectionViewCell.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/12.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCEmotionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emotionImageView: UIImageView!
    // set方法
    var emotionModel : LYCEmotionModel? {
        didSet{
            emotionImageView.image = UIImage(named: emotionModel!.emotionName)
            emotionImageView.contentMode = .center
        }
    }
}
