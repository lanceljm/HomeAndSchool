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

///只读计算型属性，不保存值，值参与计算后返回最新值
var baseURLString:String? {
    return UserDefaults.standard.object(forKey: IPSaveKey) as? String
}
