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
    var message:HSMessageModel {
        didSet {
            self.likeAttributeString = getLikeNameWithAttribute()
            setReplayListView()
        }
    }
    //点赞文本属性
    var likeAttributeString:NSAttributedString?
    //回复列表的文本属性数组
    var replayListAttirbutes = [NSAttributedString]()
    //回复视图的总高度
    var replayListViewHeight:CGFloat = 100

    
    init(model:HSMessageModel) {
        self.message = model
        self.likeAttributeString = getLikeNameWithAttribute()
        setReplayListView()
    }
    
    //将点赞人名字符串转换为带点赞图片的属性字符串
    func getLikeNameWithAttribute() -> NSAttributedString? {
        
        //MARK:图片转文本、字符串（属性）
        //转图片
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "notifi_support_press")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        let imageAttributeStr = NSAttributedString(attachment: attachment)
        
        //判断点赞字符串是否有值
        if message.likenum == 0 {
            return nil
        }
        
        //MARK:字符串转文本、字符串属性
        //转文字
        let likeStr = " " + (message.likelist ?? "")
        let likeAttributeStr = NSAttributedString(string: likeStr)
        
        //拼接
        let attributeStr = NSMutableAttributedString(attributedString: imageAttributeStr)
        attributeStr.append(likeAttributeStr)
        return attributeStr
    }
    
    //计算父文本的父视图，并计算内容的高度
    func setReplayListView() {
        //总高度
        var replayViewHeight:CGFloat = 0
        //计算背景视图的宽度
        let replayListViewBackGroundWidth = screenW - 3*margin - messageIconWidth
        //点赞文本的高度
        /*这里说的高度是按照实际文本内容计算出的高度，因此文本高度是未知的*/
        let maxSize = CGSize(width: replayListViewBackGroundWidth - 2*margin, height: CGFloat(MAXFLOAT))
        
        if message.likenum > 0 {
            let likeTextHeight = likeAttributeString!.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil).size.height
            replayViewHeight = likeTextHeight + margin + 5
        }
        //获得回复列表的数组
        let replayListArr = message.replaylist as! [HSReplayListModel]
        //创建一个保存父文本的数组
        var attributeArr = [NSAttributedString]()
        //循环转换
        for replayModel in replayListArr {
            //将用户名转换为文本
            let nameAttributeContent = NSMutableAttributedString(string:replayModel.int_name ?? "" , attributes: [NSForegroundColorAttributeName:UIColor.colorWithHex(hexColor: 0x00a0e9),NSFontAttributeName:replayListViewContentTextFont])
            //: 回复内容
            let contentStr = ": " + (replayModel.int_content ?? "")
            //将回复内容转换为文本//拼接字符串的第二个字符串没有必要是可变的
            let contentAttribute = NSAttributedString(string: contentStr, attributes: [NSForegroundColorAttributeName:UIColor.colorWithHex(hexColor: 0x808080),NSFontAttributeName:replayListViewContentTextFont])
            //拼接成一条完整的回复信息
            nameAttributeContent.append(contentAttribute)
            //把信息逐条加到数组中
            attributeArr.append(nameAttributeContent)
            //计算回复文本内容的高度
            //这里是计算每一条文本的高度
            let replayContentHeight = nameAttributeContent.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil).size.height
            //获得实际回复文本的高度//包括底部高度
            replayViewHeight += replayContentHeight + 5
        }
        //点赞人名和内容之间的间隔
        if attributeArr.count > 0 {
            //有点赞的人才有间隔
            replayViewHeight += 8
        }
        
        //赋值给属性
        self.replayListAttirbutes = attributeArr
        self.replayListViewHeight = replayViewHeight
    }
    
    
}
