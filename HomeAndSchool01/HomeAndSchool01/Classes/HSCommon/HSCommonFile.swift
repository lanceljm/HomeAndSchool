//
//  HSCommonFile.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/23.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

///整个程序的全局
let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height

//
let IPSaveKey = "IPSaveKey"

//用户字典信息
let userInfoKey = "UserInfo"

//MARK:回复回复视图的默认参数
//视图的垂直间距
let margin:CGFloat = 8
//头像的宽度
let messageIconWidth:CGFloat = 50
//回复列表的字体大小
let replayListViewContentTextFont:UIFont = UIFont.systemFont(ofSize: 12)

///只读计算型属性，不保存值，值参与计算后返回最新值
var baseURLString:String? {
    return UserDefaults.standard.object(forKey: IPSaveKey) as? String
}

//获取学生信息字典
var userInfo:NSDictionary {
    return UserDefaults.standard.object(forKey: userInfoKey) as! NSDictionary
}

//获取学生的主键ID
var userID:String {
    return userInfo["id"] as! String
}
