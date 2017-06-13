//
//  LiveViewController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

fileprivate let kChatToolViewHeight : CGFloat = 44.0

class LYCRoomViewController: UIViewController , LYCEmitterProtocol {
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    
    fileprivate lazy var chatToolsView : LYCChatToolView = LYCChatToolView.loadNibAble()
//    fileprivate lazy var gifView : LYCGifView = {
//        //let gifView = LYCGifView
//    
//    }
    
   
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObserver()
        
    }
    
    
    deinit {
        print(" room  deinit" )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


// MARK:- 设置UI界面内容
extension LYCRoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
        setupGifView()
        
    }
    // 设置毛玻璃
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    // 设置顶部聊天框
    private func setupBottomView() {
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width , height:kChatToolViewHeight )
        chatToolsView.autoresizingMask = [.flexibleTopMargin,.flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)

    }
    
    private func setupGifView(){
        LYCGifViewModel.shareInstance.loadGifData(finishCallBack: {
            print("ddd")
            

        })
    
    }
}

extension LYCRoomViewController {
    
    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeFrame (_:)) , name: .UIKeyboardWillChangeFrame, object: nil)
        
    }
}

// MARK:- 事件监听
extension LYCRoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
           chatToolsView.chatTextFiled.becomeFirstResponder()
        case 1:
            print("点击了分享")
        case 2:
            print("点击了礼物")
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            sender.isSelected ? addEmitter(point: CGPoint(x: sender.center.x, y: UIScreen.main.bounds.size.height - sender.center.y)) : stopEmitter()
            
        default:
            fatalError("未处理按钮")
        }
    }
    //
    @objc fileprivate func emotionButtonClick(_ sender : UIButton){
        
        sender.isSelected = !sender.isSelected
        print("…………………………")
    }
    
    @objc fileprivate func keyBoardWillChangeFrame (_ notify : Notification){
        
        let userInfo = notify.userInfo as! Dictionary<String, Any>
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let value = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyBoardFrame = value.cgRectValue
        let chatToolY = keyBoardFrame.minY - kChatToolViewHeight
        UIView.animate(withDuration: duration) {
            self.chatToolsView.frame.origin.y = chatToolY
        }
    }
}

extension LYCRoomViewController : LYCChatToolViewDelegate{
    func chatToolView(_ chatToolView: LYCChatToolView, message: String) {
        print(message)
    }

}