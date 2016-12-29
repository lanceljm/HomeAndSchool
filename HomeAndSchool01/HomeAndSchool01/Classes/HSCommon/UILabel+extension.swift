//
//  UILabel+extension.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/28.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

extension UILabel {
    //便利构造方法
    /*给uilabel添加方法，不能作为初始化方法*/
    convenience init(attributedTitle:NSAttributedString?,fontsize:CGFloat) {
        self.init()
        attributedText = attributedTitle
        font = UIFont.systemFont(ofSize: fontsize)
        textAlignment = .left
        numberOfLines = 0//默认行数为0行，自适应
    }
    
    convenience init(title:String,color:UIColor,fontsize:CGFloat,layoutWith:CGFloat = 0/*默认为0，可以便利出两种方法，一种有layoutWith，另一种没有*/) {
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontsize)
        numberOfLines = 0
        
        if layoutWith > 0 {
            preferredMaxLayoutWidth = layoutWith
            textAlignment = .left
        }else {
            textAlignment = .center
        }
        sizeToFit()
    }
}
