//
//  HSClassroomModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSClassroomModel: NSObject {

    var answerid:String?
    var answerkey:String?
    var answertype:String?
    var checkid:String?
    var checkkey:String?
    var classid:Int = 0
    //课程名字
    var course:String?
    //老师名字
    var createName:String?
    var creatid:Int = 0
    //创建时间
    var creattime:String?
    var id:Int = 0
    var msgtype:String?
    var outtime:Int = 0
    //头像
    var path:String?
    var piccreattime:String?
    var picgroupid:Int = 0
    //测试题目
    var picgroupname:String?
    var picnumber:Int = 0
    var picquestid:Int = 0
    var picstyle:String?
    var score:String?
    var sourceid:Int = 0
    var studentid:Int = 0
    var style:Int = 0
    var subpicgroupid:Int = 0
    var userbirthday:String?
    var usercode:String?
    var userid:Int = 0
    var username:String?
    var userphoto:String?
    var usersex:String?
    var zuoyeid:Int = 0
    
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}



/*
 {
 answerid = "<null>";
 answerkey = "";
 answertype = "<null>";
 checkid = "<null>";
 checkkey = "<null>";
 classid = 1071394;
 course = "\U8bed\U6587";
 createName = "\U8001\U5e081";
 creatid = 1;
 creattime = "2016-08-02 18:46:07.0";
 id = 17014;
 msgtype = lianxi;
 outtime = 3600;
 path = "file/1/coursepic/T/b14e48a5880845ab8f5517b82dd128f5.png";
 piccreattime = "2016-08-02 18:46:06.0";
 picgroupid = 363;
 picgroupname = "\U2605\U8bed\U65874559583";
 picnumber = 1;
 picquestid = 0;
 picstyle = png;
 score = "";
 sourceid = 363;
 studentid = 10;
 style = 2;
 subpicgroupid = 348;
 userbirthday = "*";
 usercode = t001;
 userid = 1;
 username = "\U8001\U5e081";
 userphoto = "<null>";
 usersex = "\U7537";
 zuoyeid = 0;
 },
 
 */
