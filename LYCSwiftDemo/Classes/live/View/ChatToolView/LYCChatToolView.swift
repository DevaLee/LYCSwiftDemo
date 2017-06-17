//
//  LYCChatToolView.swift
//  LYCSwiftDemo
//
//  Created by yuchen.li on 2017/6/12.
//  Copyright © 2017年 zsc. All rights reserved.
//

import UIKit

@objc protocol LYCChatToolViewDelegate : class {
   @objc optional func chatToolView(_ chatToolView : LYCChatToolView , message : String)
}

class LYCChatToolView: UIView , LYCNibAbleProtocol{

    @IBOutlet weak var chatTextFiled: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    // 若为 ！ 则需要初始化方法
    weak var delegate : LYCChatToolViewDelegate?
    fileprivate lazy var emotionButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    fileprivate  var emotionView : LYCEmotionView = LYCEmotionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 250))
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func sendButoonClick(_ sender: UIButton) {
        
        guard let message = chatTextFiled.text else {
            return
        }
        sender.isEnabled = false
        chatTextFiled.text = nil
        delegate?.chatToolView!(self, message: message)
    }
}

extension LYCChatToolView{
    
    fileprivate func setupUI(){
        // 表情按钮
        emotionButton.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emotionButton.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emotionButton.addTarget(self, action: #selector(emotionButtonClick(_:)), for: .touchUpInside)
        chatTextFiled.rightView = emotionButton
        chatTextFiled.rightViewMode = .always
        
        // emo表情 View
        //(weak当对象销毁值, 会自动将指针指向nil)
        // weak var weakSelf = self
        emotionView.emotionClickCallBack = {  emotionModel in
            if emotionModel.emotionName == "delete-n" {
                self.chatTextFiled.deleteBackward()
                return
            }else{
                self.sendButton.isEnabled = true
                guard  let range = self.chatTextFiled.selectedTextRange else {
                    print("range 为nil")
                    return
                }
                self.chatTextFiled?.replace(range, withText: emotionModel.emotionName)
            }
            
        }
        // 发送框
        chatTextFiled.delegate = self
    }
}

extension LYCChatToolView : UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.sendButton.isEnabled = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.sendButton.isEnabled = true
        return true
    }

}

// MARK:- 响应事件
extension LYCChatToolView{
    
    @objc fileprivate func emotionButtonClick(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        
        /*
         inputView就是显示键盘的view,如果重写这个view则不再弹出键盘，而是弹出自己的view.如果想实现当某一控件变为第一响应者时不弹出键盘而是弹出我们自定义的界面，那么我们就可以通过修改这个inputView来实现，比如弹出一个日期拾取器。
         
         inputView不会随着键盘出现而出现，设置了InputView只会当UITextField或者UITextView变为第一相应者时显示出来，不会显示键盘了。设置了InputAccessoryView，它会随着键盘一起出现并且会显示在键盘的顶端。InutAccessoryView默认为nil
         inputAccessoryView：在顶端
         */
        let range = chatTextFiled.selectedTextRange
        chatTextFiled.resignFirstResponder()
        chatTextFiled.inputView = chatTextFiled.inputView == nil ? emotionView : nil
        chatTextFiled.becomeFirstResponder()
        chatTextFiled.selectedTextRange = range
    }

}
