//
//  HSMessageModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/29.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageModel: NSObject {

    var likelist:String?
    var likenum:Int = 0
    var not_Name:String?
    var not_content:String?
    var not_courseName:String?
    var not_createDate:String?
    var not_id:Int = 0
    var not_sex:String?
    var not_tId:Int = 0
    var not_title:String?
    var not_tpath:String?
    var not_type:Int = 0
    var replaylist:NSArray?
    
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}


/*
 
 Optional({
 data =     (
 {
 likelist = "";
 likenum = 0;
 "not_Name" = "\U738b\U6653\U5b87 \U5bb6\U957f";
 "not_content" = " ";
 "not_courseName" = "\U5bb6\U957f";
 "not_createDate" = "2016-12-29 17:06:00";
 "not_id" = 165;
 "not_sex" = "\U5973";
 "not_tId" = 10;
 "not_title" = "\U53d1\U751fdf";
 "not_tpath" = "";
 "not_type" = 2;
 replaylist =             (
 );
 },
 
 */
