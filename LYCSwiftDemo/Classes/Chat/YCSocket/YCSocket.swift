//
//  YCSocket.swift
//  Client
//
//  Created by 李玉臣 on 2017/6/13.
//  Copyright © 2017年 yuchen.li. All rights reserved.
//

import UIKit

protocol YCSocketDelegate : class{
    func socket(_ socket : YCSocket , joinRoom userInfo : UserInfo)
    func socket(_ socket : YCSocket , leaveRoom userInfo : UserInfo)
    func socket(_ socket : YCSocket ,  chatMsg : TextMessage)
    func socket(_ socket : YCSocket , sendGif gif : GiftMessage)
}

class YCSocket: NSObject {
    fileprivate var tcpClient : TCPClient
    weak var delegate : YCSocketDelegate?
    fileprivate var userInfo : UserInfo.Builder = {
        let userInfo = UserInfo.Builder()
        userInfo.name = "张(\(arc4random_uniform(20)))"
        userInfo.level = Int64(arc4random_uniform(10))
        return userInfo
    }()
    
    init(addr : String , port : Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }

}
//MARK:-对外暴露方法
extension YCSocket {
    // 连接到服务器
    func connectServer() -> Bool {
        //返回值是一个元组 取Bool
        return tcpClient.connect(timeout: 5).0
    }
    /* 读取数据 */
   func startReadMsg(){
        DispatchQueue.global().async {
            while true{
                // 读取 头信息
                guard let lmsg = self.tcpClient.read(4) else{
                    continue
                }
                let headData = Data(bytes: lmsg, count: 4)
                var length : Int = 0
                (headData as NSData).getBytes(&length, length: 4)
                // 读取文件类型
                guard let typeMsg = self.tcpClient.read(2) else {
                    return
                }
             
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                // 根据长度读取真实信息
                guard let msg = self.tcpClient.read(length) else {
                    return;
                }
                let data = Data(bytes: msg, count: length)
                // 处理消息
                DispatchQueue.main.async {
                    self.handleMsg(type: type, data: data)
                }
            }
        }
    
    
    }
    fileprivate func handleMsg(type : Int , data : Data){
        switch type {
        case 0, 1:
            // UserInfo
            let user = try! UserInfo.parseFrom(data: data)
            type == 0 ? delegate?.socket(self, joinRoom: user) : delegate?.socket(self, leaveRoom: user)
        case 2 :
            let chatMsag = try! TextMessage.parseFrom(data: data)
            delegate?.socket(self, chatMsg: chatMsag)
        case 3 :
            let gifMsg = try! GiftMessage.parseFrom(data: data)
            delegate?.socket(self, sendGif: gifMsg)
        case 100:
            _ = 1
        default:
            print("未知类型")
        }
    }
}

extension YCSocket {
    
    func sendJoinRoom(){
        let msgData = (try! userInfo.build()).data()
        sendMsg(data: msgData, type: 0)
    }
    
    func sendLeaveRoom(){
        let msgData = (try! userInfo.build()).data()
        sendMsg(data: msgData, type: 1)
    }
    
    func sendTextMessage(textMsg : String){
        let textMessage = TextMessage.Builder()
        textMessage.user = try! userInfo.build()
        textMessage.text = textMsg
        let msgData = try! textMessage.build().data()
        sendMsg(data: msgData, type: 2)
    }
    
    func sendGif(gifName : String , gifUrl : String , gifNum : String){
        let gifMessage = GiftMessage.Builder()
        gifMessage.user = try! userInfo.build()
        gifMessage.giftname = gifName
        gifMessage.giftUrl = gifUrl
        gifMessage.giftCount = gifNum
        
        let gifData = (try! gifMessage.build()).data()
        sendMsg(data: gifData, type: 3)
    }
    
    func sendHeartBeat() {
        // 1.获取心跳包中的数据
        let heartString = "I am is heart beat;"
        let heartData = heartString.data(using: .utf8)!
        
        // 2.发送数据
        sendMsg(data: heartData, type: 100)
    }
    
    fileprivate  func sendMsg(data : Data , type : Int){
        // 将消息长度写入到data
        var length = data.count
        // 拷贝4个字节
        let headerData = Data(bytes: &length, count: 4)
        
        // 2，消息类型
        var tempType = type
        let typeData = Data(bytes: &tempType, count: 2)
        
        // 3,发送全部消息
        let msgData = headerData + typeData + data
        tcpClient.send(data: msgData)
    }
}
