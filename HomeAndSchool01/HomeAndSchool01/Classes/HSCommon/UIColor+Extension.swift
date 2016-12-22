//
//  UIColor+Extension.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

extension UIColor {
    ///颜色转换
    class func colorWithHex(hexColor:uint) -> UIColor {
        //位操作运算获得对应的RGB颜色值
        let r:uint = hexColor >> 16 //0x44
        let g:uint = hexColor >> 8 & 0xFf //0x55
        let b:uint = hexColor & 0xFF    //0x77
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1/0)
    }
}
