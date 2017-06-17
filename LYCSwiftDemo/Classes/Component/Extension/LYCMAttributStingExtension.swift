//
//  LYCMAttributStingExtension.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/17.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit
import Kingfisher

class LYCMAttributStingExtension: NSObject {
    
    

}

extension LYCMAttributStingExtension{
    /*进入或者离开房间*/
    class func userJoinLeaveRoom(userName : String , isJoinRoom : Bool) -> NSMutableAttributedString{
        let roomStr = isJoinRoom ? " :进入房间" : " :离开房间"
        let joinText = NSMutableAttributedString(string: userName + roomStr)
        joinText.addAttributes([NSForegroundColorAttributeName : UIColor.themeColor()], range: NSMakeRange(0, userName.characters.count))
        return joinText
    }
    /*发送一段文字*/
    class func userSendMsg(userName : String , chatMsg : String) -> NSMutableAttributedString{
        
        let msg = userName + ":" + chatMsg
        
        let attriChat = NSMutableAttributedString(string: msg)
        
        attriChat.addAttributes([NSForegroundColorAttributeName : UIColor.themeColor()], range: NSMakeRange(0, userName.characters.count))
 
        let pattern = "\\[.*?\\]"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        guard let regexResult = regex?.matches(in: msg, range: NSMakeRange(0, msg.characters.count)) else {
            return attriChat
        }
        for i in (0..<regexResult.count).reversed() {
            let result = regexResult[i]
            let emotionName = (msg as NSString).substring(with: result.range)
            let emotionImage = UIImage(named: emotionName)
            //创建一个富文本
            let attachText = NSTextAttachment()
            attachText.image = emotionImage
            let font = UIFont.systemFont(ofSize: 15)
            attachText.bounds = CGRect(x: 0, y: -3, width:font.lineHeight , height: font.lineHeight)
            let emoAttributeString = NSAttributedString(attachment: attachText)
            
            // 替换文字为相对应的表情图片
            attriChat.replaceCharacters(in: result.range, with: emoAttributeString)
        }
        return attriChat
    }
    /*发送礼物*/
    class  func sendGif(userName : String , gifUrl : String , gifName : String ) -> NSMutableAttributedString{
        let msg = userName + " 送出 " + gifName
        
        let mAttriMsg = NSMutableAttributedString(string: msg)
        mAttriMsg.addAttributes([NSForegroundColorAttributeName : UIColor.themeColor()], range: NSMakeRange(0, userName.characters.count))
        
        let range = ( msg as NSString).range(of: gifName)
        mAttriMsg.addAttributes([NSForegroundColorAttributeName : UIColor.brown], range: range)
        
        guard  let gifImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: gifUrl) else {
            return mAttriMsg
        }
        
        let textAttach = NSTextAttachment()
        textAttach.image = gifImage
        textAttach.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        let gifAttri = NSAttributedString(attachment: textAttach)
        mAttriMsg.append(gifAttri)
        return mAttriMsg
    }

}
