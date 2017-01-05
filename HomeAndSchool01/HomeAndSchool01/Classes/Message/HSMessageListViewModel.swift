//
//  HSMessageListViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

//定义刷新类型的枚举
enum LoadType {
    case down
    case up
}

class HSMessageListViewModel {

    //数据源数组，存放消息模型
    var messageModels:[HSMessageViewModel] = []
    
    //加载数据
    func loadDate(refresh:LoadType , finished:@escaping ((_ isRefresh:Bool) -> ())) {
        //获得接口
        let urlStr = "ZH-schoolname-S-getJXNotification"
        //最后一条通知的id
        let lastNot_id = messageModels.last?.message.not_id ?? 0
        //获得当前刷新通知的id
        let not_id = (refresh == .down) ? 0:lastNot_id
        //刷新类型
        let load_type = (refresh == .down) ? 1:2
        
        //参数
        let parm:[String:Any] = ["key":userID,"id":not_id,"load_type":load_type]
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
                //创建一个可变的数组保存模型
                var messageVMArr = [HSMessageViewModel]()
                
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
                    messageVMArr.append(HSMessageViewModel(model: messageM))
                }
                //赋值给外部属性
                if refresh == .down {
                    self?.messageModels = messageVMArr
                }else {
                    self?.messageModels += messageVMArr
                }
                //是否加载数据
                finished(true)
            case 1:
                HSAlertView.bottomAlertView("数据加载异常或已经没有数据了")
                finished(false)
            default:
                break
            }
        }
        
        
    }
}
