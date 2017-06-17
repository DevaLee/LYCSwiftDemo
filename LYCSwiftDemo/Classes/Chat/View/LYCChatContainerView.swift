//
//  LYCChatContainerView.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/17.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

private let kCellId = "kCellId"
private let kLYCChatTableViewCell = "LYCChatTableViewCell"
class LYCChatContainerView: UIView , LYCNibAbleProtocol {
    var chatMsgs : [NSMutableAttributedString] = []

    @IBOutlet weak var chatTabView: UITableView!

    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        chatTabView.dataSource = self
        chatTabView.separatorStyle = .none
        chatTabView.backgroundColor = UIColor.clear
        chatTabView.register( UINib(nibName: kLYCChatTableViewCell, bundle: nil), forCellReuseIdentifier: kCellId)
        chatTabView.estimatedRowHeight = 44
        chatTabView.rowHeight = UITableViewAutomaticDimension
    }
}
//
extension LYCChatContainerView {
     func addAttributeStringReloadData(attrSting : NSMutableAttributedString ){
            chatMsgs.append(attrSting)
            chatTabView.reloadData()
        let indexPath = IndexPath(item: chatMsgs.count - 1, section: 0)
        chatTabView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

//MARK:- UITableViewDelegate
extension LYCChatContainerView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatMsgs.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! LYCChatTableViewCell
        cell.chatMsgLable.attributedText = chatMsgs[indexPath.row]
        return cell
    }
}
