//
//  HSMessageViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/30.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageViewModel {

    //当前消息模型
    var message:HSMessageModel
    //点赞文本属性
    var likeAttributeString = NSAttributedString()
    //回复列表的文本属性数组
    let replayListAttirbutes = [NSAttributedString]()
    

    
    init(model:HSMessageModel) {
        self.message = model
        self.likeAttributeString = getLikeNameWithAttribute()
    }
    
    //将点赞人名字符串转换为带点赞图片的属性字符串
    func getLikeNameWithAttribute() -> NSAttributedString {
        
        //MARK:图片转文本、字符串（属性）
        //转图片
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "notifi_support_press")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        let imageAttributeStr = NSAttributedString(attachment: attachment)
        
        //MARK:字符串转文本、字符串属性
        //转文字
        let likeStr = " " + (message.likelist ?? "")
        let likeAttributeStr = NSAttributedString(string: likeStr)
        
        //拼接
        let attributeStr = NSMutableAttributedString(attributedString: imageAttributeStr)
        attributeStr.append(likeAttributeStr)
        return attributeStr
    }
    
    
}
