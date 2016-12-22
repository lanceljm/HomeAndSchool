//
//  Bundle+Extension.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import Foundation


//swift中，延展和OC相同，只能增加方法，不能增加属性
//和OC不同的是swift中可以增加计算型属性
extension Bundle {
    //扩展的命名空间名称获取属性
    var bundleName :String? {
        guard let filePath = path(forResource: "Info", ofType: "plist"),
            let infoDic = NSDictionary(contentsOfFile:filePath)  else {
            return nil
        }
        return infoDic["CFBundleName"] as? String
    }
    
    
}
