//
//  HSHomeworkSubViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
//主观题
class HSHomeworkSubViewModel {
    
    var dataArray = [HSHomeworkSubModel]()
    
    func loadNetwork() {
        //接口
        let urlStr = "ZH-schoolname-S-getHomeworkCheck"
        //参数
        let parm:[String:Any] = ["key":userID,"hw_id":3]
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary else {
                HSAlertView.bottomAlertView("网络异常")
                return
            }
            print("------------------主观题作业详情----------------------,\(data)")
            
        }
        
    }

    
}
