//
//  HSScheduleModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/28.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScheduleModel: NSObject {
    var bak:String?
    var courseId:String?
    var courseName:String?
    var curriculumTime:String?
    var teacherID:String?
    var teacherName:String?
    var weekName:String?
    
    //字典转数组
    init(dic:[String:String]) {
        super.init()//使用KVC时卸载赋值前，其余状况写在后边
        setValuesForKeys(dic)
    }
    
    //忽略多余的key
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}




/*
 c1 =             {
 bak = C1;
 courseId = 1079132;
 courseName = "\U5916\U8bed";
 curriculumTime = "\U7b2c1\U8282";
 teacherID = t002;
 teacherName = "\U8001\U5e082";
 weekName = "\U661f\U671f\U4e00";
 };
 */
