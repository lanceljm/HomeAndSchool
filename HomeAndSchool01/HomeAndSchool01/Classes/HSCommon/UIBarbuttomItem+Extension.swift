//
//  UIBarbuttomItem+Extension.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/23.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit//定义UI开头的属性要把这里改成UIKit

extension UIBarButtonItem {
    //便利构造方法
    convenience init?(imageName:String,taget:Any?,action:Selector) {
        
        //初始化一个button
        let btn = UIButton(type: .custom)
        //获得图片、守护
        guard
            let imageNol = UIImage(named: "\(imageName)_nor") ,
            let imageHighlight = UIImage(named: "\(imageName)_press")
            else {
                return nil//有可能失败，所以返回nil
        }
        //使图片的大小和传入的大小相同
        btn.frame = CGRect(x: 0, y: 0, width: imageNol.size.width, height: imageNol.size.height)
        btn.setBackgroundImage(imageNol, for: .normal)
        btn.setBackgroundImage(imageHighlight, for: .highlighted)
        btn.addTarget(taget, action: action, for: .touchUpInside)
        self.init(customView:btn)
    }
}



