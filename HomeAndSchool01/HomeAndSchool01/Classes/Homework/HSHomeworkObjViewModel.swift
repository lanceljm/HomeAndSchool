//
//  HSHomeworkObjViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.


/*
 String  course
 String  username
 String  style
 (主观 3、客观 2、笔记 1)
*/
//

import UIKit
//客观题
class HSHomeworkObjViewModel {

    var dataArray = [HSHomeworkObjModel]()
    
    func loadNetwork() {
        //接口
        let urlStr = "ZH-schoolname-S-getHomeworkCheck"
        //参数
        let parm:[String:Any] = ["key":userID,"hw_id":2]
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary else {
                HSAlertView.bottomAlertView("网络异常")
                return
            }
            print("------------------客观题作业详情----------------------,\(data)")
            
        }
        
    }
    
}
