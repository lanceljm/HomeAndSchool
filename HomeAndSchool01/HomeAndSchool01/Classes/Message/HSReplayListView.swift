//
//  HSReplayListView.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/30.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit
import SnapKit

class HSReplayListView: UIView {

    //点赞家长名字
    @IBOutlet weak var likeListLabel:UILabel!
    //分割线
    @IBOutlet weak var likeLineView:UIView!
    
    //记录当前已经添加的标签视图
    var replayListArr = [UILabel]()
    
    //接收消息模型的属性
    var messageVM:HSMessageViewModel? {
        didSet {
            //默认在添加回复列表之前，需要先清除cell上原来的标签
            for label in replayListArr {
                //先遍历删除父视图上的每一个标签
                label.removeFromSuperview()
            }
            //最后清空数组
            replayListArr.removeAll()
            
            //MARK:给label赋值
            likeListLabel.attributedText = messageVM?.likeAttributeString
            
            //获得点赞人数
            let likeNum = messageVM?.message.likenum ?? 0
            
            //获得回复人数
            let replayNum = messageVM?.replayListAttirbutes ?? []
            
            //如果没有人点赞，隐藏分割线
            if likeNum == 0||replayNum.count == 0 {
                likeLineView.isHidden = true
            }else {
                likeLineView.isHidden = false
            }
            
            //添加回复列表视图
            for attributeStr in replayNum {
                let lab = UILabel(attributedTitle: attributeStr, fontsize: 12)
                lab.textAlignment = .left
                addSubview(lab)
                //添加到数组记录中
                replayListArr.append(lab)
            }
            
            //使用三方约束视图
            for (i,v) in replayListArr.enumerated() {
                if i == 0 {
                    if likeNum == 0 {
                        v.snp.makeConstraints({ (make) in
                            make.top.equalTo(self.snp.top).offset(8)
                            make.left.equalTo(self.snp.left).offset(8)
                            make.right.equalTo(self.snp.right).offset(-5)
                        })
                    }else {
                        v.snp.makeConstraints({ (make) in
                            make.top.equalTo(likeLineView.snp.bottom).offset(5)
                            make.left.equalTo(self.snp.left).offset(8)
                            make.right.equalTo(self.snp.right).offset(-5)
                        })
                    }
                }else {
                    v.snp.makeConstraints({ (make) in
                        make.top.equalTo(replayListArr[i-1].snp.bottom).offset(5)
                        make.right.equalTo(self.snp.right).offset(-5)
                        make.left.equalTo(self.snp.left).offset(8)
                    })
                }
            }
        }
    }
    
    

}
