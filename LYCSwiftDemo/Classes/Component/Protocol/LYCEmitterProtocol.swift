//
//  LYCEmitterProtocol.swift
//  LYCSwiftDemo
//
//  Created by 李玉臣 on 2017/6/11.
//  Copyright © 2017年 zsc. All rights reserved.
//

import Foundation
import UIKit

protocol LYCEmitterProtocol  {

}
// 协议,结构体，里面不可以定义类方法即class方法 可以定义静态方法 static
// where Self 对协议添加约束   Self : Self关键字只能用在类里， 作为函数返回值类型， 表示当前类
extension LYCEmitterProtocol where Self : UIViewController{
    // 对象方法
    func addEmitter(point : CGPoint ){
        let emitterLayer = CAEmitterLayer()
        //位置
        emitterLayer.emitterPosition = point;
        // 添加三维效果
        emitterLayer.preservesDepth = true;
        //
        var cells = [CAEmitterCell]()
        for i in 0 ..< 10 {
            let emitterCell = CAEmitterCell()
            // 一秒有3个
            emitterCell.birthRate = 2
            // 粒子的内容
            emitterCell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            
            emitterCell.lifetime = 5
            // 上下波动数为2
            emitterCell.lifetimeRange = 3
            
            emitterCell.emissionLongitude = CGFloat(-.pi * 0.5)
            
            emitterCell.emissionRange = .pi * 0.1
            
            emitterCell.velocity = 150
            
            emitterCell.velocityRange = 100
            
            cells.append(emitterCell)
        }
        
        emitterLayer.emitterCells = cells
        
        view.layer.addSublayer(emitterLayer)
    }
    func stopEmitter(){
        view.layer.sublayers!.filter( { $0.isKind(of: CAEmitterLayer.self) } ).first?.removeFromSuperlayer()
    }

}
