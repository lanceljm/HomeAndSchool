//
//  HSMessageListViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageListViewModel {

    //数据源数组，存放消息模型
    var messageModels:[HSMessageViewModel] = []
    
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
                    
                    //获得回复列表的字典数组
                    let replayListDA = messageM.replaylist as! [[String:Any]]
                    
                    
                    //赋值列表模型数组
                    var replayListMArr = [HSReplayListModel]()
                    for dic in replayListDA {
                        let releaseM = HSReplayListModel(dict: dic)
                        //添加到数组中
                        replayListMArr.append(releaseM)
                    }
                    
                    //MARK:将转换好的回复列表模型数组赋值给消息模型属性
                    messageM.replaylist = replayListMArr
                    
                    
                    
                    //添加到数组--消息模型属性
                    self?.messageModels.append(HSMessageViewModel(model: messageM))
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
