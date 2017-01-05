//
//  HSMessageCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageCell: UITableViewCell {
    
    //定义点赞按钮的回调闭包属性
    var likeBtnBlock:((_ cell:HSMessageCell) -> ())?
    var replyBtnBlock:((_ cell:HSMessageCell) -> ())?
    
    
    @IBOutlet weak var messageIconV: UIImageView!
    
    @IBOutlet weak var messageNameLabel: UILabel!
    
    @IBOutlet weak var messageUserTypeLabel: UILabel!

    @IBOutlet weak var messageDateLabel: UILabel!
    
    @IBOutlet weak var messageTitleLabel: UILabel!
    
    @IBOutlet weak var messageContentLagel: UILabel!
    //点赞
    @IBOutlet weak var messageBtn: UIButton!
    
    @IBOutlet weak var messageReplyView: HSReplayListView!
    
    @IBOutlet weak var messageRepalyListViewHeight:NSLayoutConstraint!
    
    
    //接收数据的模型
    var messageVM:HSMessageViewModel? {
        didSet {
            //头像
            let path = messageVM?.message.not_tpath ?? ""
            if path != "" {
                let urlStr = "http://120.24.57.38/new/zao/" + path
                //下载图片
                messageIconV.setImageWith(URL(string:urlStr)!, placeholderImage: UIImage(named: "boy"))
            }else {
                messageIconV.image = UIImage(named: "boy")
            }
            
            messageNameLabel.text = messageVM?.message.not_Name
            messageDateLabel.text = messageVM?.message.not_createDate
            messageTitleLabel.text = messageVM?.message.not_title
            messageContentLagel.text = messageVM?.message.not_content
            
            //设置点赞数和显示高亮状态
            if (messageVM?.message.likenum)! > 0 {
                messageBtn.isSelected = true
                messageBtn.setTitle("\(messageVM?.message.likenum ?? 0)", for: .selected)
            }else {
                messageBtn.isSelected = false
            }
            
            //传递数据给回复视图
            messageReplyView.messageVM = messageVM
            
            //更新视图高度
            messageRepalyListViewHeight.constant = messageVM?.replayListViewHeight ?? 0
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //加载的时候调用一次
        messageIconV.layer.cornerRadius = 25
        messageIconV.layer.masksToBounds = true
        
        messageUserTypeLabel.layer.cornerRadius = 8
        
        messageUserTypeLabel.layer.borderWidth = 1
        messageUserTypeLabel.layer.borderColor = UIColor.colorWithHex(hexColor: 0x00a0e9).cgColor
    }
    
    //点赞
    @IBAction func messageLikeBtnClicked(_ sender: UIButton) {
        //使用闭包传值
        likeBtnBlock?(self)
    }

    //回复
    @IBAction func messageReplyBtnClicked(_ sender: UIButton) {
        replyBtnBlock?(self)
    }
    
    
}
