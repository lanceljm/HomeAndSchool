//
//  HSAFNWorkTools.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/26.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit
import AFNetworking

//自定义block，并给他重命名
typealias callBackBlock = (_ data:Any?,_ err:Error?) -> ()

class HSAFNWorkTools: AFHTTPSessionManager {

    //使用单例实例化一个网络工具
    //只能初始化一次，且不能被修改
    static let shared:HSAFNWorkTools = {
      //初始化工具类属性
        let instance = HSAFNWorkTools(baseURL: URL(string: baseURLString!))
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return instance
    }()
    
    //MARK:封装网络方法
    func request(url:String,parameters:Any?,finished:@escaping callBackBlock) {
        //调用三方网络请求数据
        get(url, parameters: parameters, progress: nil, success: { (_, data) in
            finished(data, nil)
        }) { (_, err) in
            finished(nil, err)
        }
    }
}
