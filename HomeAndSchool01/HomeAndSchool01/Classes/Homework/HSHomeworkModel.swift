//
//  HSHomeworkModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/30.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSHomeworkModel: NSObject {

    var checkStatus:Int = 0
    var courseName:String?
    var hw_courseId :Int = 0
    var hw_createDate:String?
    var hw_id:Int = 0
    var hw_tId:Int = 0
    var hw_tName:String?
    var hw_title:String?
    var subStatus:Int = 0
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}



/*
 {
 checkStatus = 1;
 courseName = "\U5916\U8bed";
 "hw_courseId" = 1079132;
 "hw_createDate" = "2016-07-30 09:17:08.0";
 "hw_id" = 17;
 "hw_tId" = 1;
 "hw_tName" = "\U8001\U5e081";
 "hw_title" = "\U4f5c\U4e1a\U6807\U9898";
 subStatus = 1;
 },
 */
