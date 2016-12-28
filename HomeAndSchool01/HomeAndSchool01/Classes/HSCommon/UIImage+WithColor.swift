//
//  UIImage+WithColor.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/27.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

extension UIImage {
    //使用颜色绘图
    class func image(withColor:UIColor) -> UIImage? {
        //获得绘图上下文
        UIGraphicsBeginImageContext(CGSize(width: 44, height: 44))
        //设置绘图颜色
        withColor.setFill()
        //绘图图片
        UIRectFill(CGRect(x: 0, y: 0, width: 44, height: 44))
        //将上下文转换为图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文/*此处必须手动关闭上下文，UIView的draw方法则不需要手动管理*/
        UIGraphicsEndImageContext()
        return newImage
    }
}
