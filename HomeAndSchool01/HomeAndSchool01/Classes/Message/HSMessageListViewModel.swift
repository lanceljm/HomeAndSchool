//
//  HSMessageListViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageListViewModel: NSObject {

    //数据源数组，存放消息模型
    var messageModels:[HSMessageModel] = []
    
    //加载数据
    func loadDate(finished:@escaping ((_ isRefresh:Bool) -> ())) {
        //获得接口
        let urlStr = "ZH-schoolname-S-getJXNotification"
        //参数
        let parm:[String:Any] = ["key":userID,"id":0,"load_type":1]
        //请求数据
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) {[weak self] (data, err) in
            guard let data = data as? NSDictionary else {
                HSAlertView.bottomAlertView("网络错误")
                return
            }
            switch data["result"] as! Int {
            case 0:
                //获得消息数组
                guard let dictArr = data["data"] as? [[String:Any]] else {
                    return
                }
                //循环转换数组
                for dict in dictArr {
                    //字典转模型
                    let messageM = HSMessageModel(dict: dict)
                    //添加到数组
                    self?.messageModels.append(messageM)
                }
                //是否加载数据
                finished(true)
            case 1:
                HSAlertView.bottomAlertView("数据加载异常")
                finished(false)
            default:
                break
            }
        }
        
        
    }
}
