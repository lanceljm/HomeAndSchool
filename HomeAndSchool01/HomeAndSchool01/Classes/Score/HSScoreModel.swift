//
//  HSScoreModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScoreModel: NSObject {

    var es_comment:String?
    var es_course:String?
    var es_createDate:String?
    var es_id:Int = 0
    var es_score:Int = 0
    var es_tId:Int = 0
    var es_teacherName:String?
    var es_title:String?
    
    init(dict:[String:Any]) {

        super.init()
        setValuesForKeys(dict)
    }
    
}

/*
 {
 "es_comment" = "\U7ee7\U7eed\U52aa\U529b";
 "es_course" = "\U6570\U5b66";
 "es_createDate" = "2016-07-07";
 "es_id" = 8;
 "es_score" = 45;
 "es_tId" = 1;
 "es_teacherName" = "\U8001\U5e081";
 "es_title" = "\U6570\U5b66\U5355\U5143\U6d4b\U8bd5";
 }
 
 */
