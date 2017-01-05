//
//  HSHomeWorkListViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

class HSHomeWorkViewModel {

    //数据源数组
    var dataArr = [HSHomeworkModel]()
    
    //下载网络数据
    func loadData(finished:@escaping (_ isOK:Bool) -> () ) {
        //获得接口
        let urlStr = "ZH-schoolname-S-getHomeworkBase"
        //参数
        let parm:[String:Any] = ["key":userID,"id":1]
        //请求数据
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary else {
                HSAlertView.bottomAlertView("网络异常")
                return
            }
//            print("-----------作业的数据-------------,\(data)")
            guard let imageStatus = data["result"] as? Int else {
                return
            }
            switch imageStatus  {
            case 0:
                guard let arr = data["data"] as? [[String:Any]] else {
                    return
                }
                for dict in arr {
                    let model = HSHomeworkModel(dict: dict)
                    self.dataArr.append(model)
                }
                finished(true)
            case 1:
                HSAlertView.bottomAlertView("加载失败")
                finished(false)
                
            default:
                break
            }
        }
        
    }
    
}
