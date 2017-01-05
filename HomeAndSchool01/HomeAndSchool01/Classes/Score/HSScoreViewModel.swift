//
//  HSScoreViewModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScoreViewModel {

    //数据源数组
    var dataArr = [HSScoreModel]()
    
    //下载网络数据
    func downLoadData(finshed:@escaping (_ isOK:Bool) -> ()) {
        //获得接口
        let urlStr = "ZH-schoolname-S-getExamScore"
        //参数
        let parm:[String:Any] = ["key":userID,"id":1]
        //请求数据
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary else {
                HSAlertView.bottomAlertView("网络异常")
                return
            }
            let status = data["result"] as! Int
            switch status {
            case 0:
                guard let dictArr = data["data"] as? [[String:Any]] else {
                    return
                }
                for dict in dictArr {
                    let model = HSScoreModel(dict: dict)
                    self.dataArr.append(model)
                }
                finshed(true)
            case 1:
                HSAlertView.bottomAlertView("加载异常")
                finshed(false)
            default:
                break
            }
        }
    }

    
}
