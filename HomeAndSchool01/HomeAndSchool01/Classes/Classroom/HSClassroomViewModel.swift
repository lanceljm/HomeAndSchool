//
//  HSClassroomViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSClassroomViewModel: NSObject {

    //数据源数组
    var dataArr = [HSClassroomModel]()
    
    //下载网络数据
    func downLoadData(finshed:@escaping (_ isOK:Bool) -> ()) {
        //获得接口
        let urlStr = "ZH-schoolname-S-getNewMessage"
        //参数
        let parm:[String:Any] = ["key":userID,"id":4,"load_type":1]
        //请求数据
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary else {
                
                HSAlertView.bottomAlertView("网络异常")
                return
            }
            guard let status = data["result"] as? Int else {
                return
            }
            switch status {
            case 0:
                guard let dictArr = data["data"] as? [[String:Any]] else {
                    return
                }
                for dict in dictArr {
                    let model = HSClassroomModel(dict: dict)
                    self.dataArr.append(model)
                }
                finshed(true)
            case 1:
                HSAlertView.bottomAlertView("加载异常")
                finshed(false)
            default :
                break
            }
            
        }
        
    }
    
}
