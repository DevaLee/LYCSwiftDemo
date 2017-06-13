//
//  LYCAnchorCollectionViewCell.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/10.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit
import Kingfisher

class LYCAnchorCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var onlineNumLabel: UILabel!
    @IBOutlet weak var liveIconImageView: UIImageView!
    
       var anchorModel : LYCAnchorTypeModel? {
        
        didSet{
            let url = URL(string: (anchorModel!.isEvenIndex ? anchorModel!.pic74 : anchorModel!.pic51))
            bgImageView.kf.setImage(with: url)
            nickNameLabel.text = anchorModel!.name
            onlineNumLabel.text = ("\(String(describing: anchorModel!.focus))")
            liveIconImageView.isHidden = anchorModel!.live == 0 ? true : false
        }
    }
    
}
