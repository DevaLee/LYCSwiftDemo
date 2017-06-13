//
//  LYCGifViewCell.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/13.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCGifViewCell: UICollectionViewCell {

    @IBOutlet weak var gifNameLabel: UILabel!
    
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var gifCostLabel: UILabel!
    @IBOutlet weak var gifImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    var gifModel : LYCGifModel? {
        didSet {
            gifNameLabel.text = gifModel?.subject
            gifCostLabel.text = "\(String(describing: gifModel?.coin))"
            let urlString = URL(string: gifModel!.gUrl)
            gifImageView.kf.setImage(with: urlString)
            gifImageView.contentMode = .center
            
            imageContentView.backgroundColor = UIColor.clear
            
            gifCostLabel.text = "\(gifModel!.coin)"
          
            
        }
    
    }
}
