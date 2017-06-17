//
//  LYCChatTableViewCell.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/17.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

class LYCChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatMsgLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        chatMsgLable.backgroundColor = UIColor.clear
        chatMsgLable.font = UIFont.systemFont(ofSize: 16)
        chatMsgLable.numberOfLines = 0
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
    }

    
}
