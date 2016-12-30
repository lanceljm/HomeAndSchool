//
//  HSAlertView.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSAlertView: NSObject {

    //自定义底部弹窗
    class func bottomAlertView(_ title:String,maxY:CGFloat = screenH/2) {
        //初始化一个label当做弹窗的视图
        let alertLabel = UILabel(title: title, color: UIColor.white, fontsize: 17)
        alertLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        alertLabel.center = CGPoint(x: screenW/2, y: maxY)
        alertLabel.backgroundColor = UIColor.black
        alertLabel.alpha = 0
        alertLabel.layer.cornerRadius = 10
        alertLabel.layer.masksToBounds = true
        alertLabel.textAlignment = .center
        //将视图添加window上
        UIApplication.shared.keyWindow?.addSubview(alertLabel)
        
//        UIView.animate(withDuration: 2.0, animations: {
//            alertLabel.alpha = 1.0
//        }) { (_) in
//            UIView.animate(withDuration: 1.0, animations: {
//                alertLabel.alpha = 0
//            }, completion: { (_) in
//                alertLabel.removeFromSuperview()
//            })
//        }
        //设置动画
        UIView.animate(withDuration: 2.0, animations: {
            alertLabel.alpha = 1.0
        }, completion: { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                alertLabel.alpha = 0.0
            }, completion: { (_) in
                alertLabel.removeFromSuperview()
            })
        })
       
    }
    
}
