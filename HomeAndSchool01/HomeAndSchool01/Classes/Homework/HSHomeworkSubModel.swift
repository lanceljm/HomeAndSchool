//
//  HSHomeworkSubModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
//主观题
class HSHomeworkSubModel: NSObject {

    var ht_id:Int = 0
    //题目序号
    var ht_order:Int = 0
    var ht_title:String?
    //题目类型
    var ht_type:Int = 0
    var hw_id:Int = 0
    var isCheck:Int = 0
    var isSub:Int = 0
    //图片路径
    var hc_photoPath:String?
    //回答状态，正确、错误
    var hs_answerStatus:String?
    //正确答案
    var ht_correctWord:String?
    //题目选项
    var ht_option:[[String:Any]]?
    
    
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

/*
 {
 "hc_comment" = "";
 "hc_photoPath" = "";
 "hc_tId" = "";
 "hc_tName" = "";
 "hs_answer" = "";
 "hs_answerStatus" = "";
 "hs_photoPath" = "";
 "ht_correctWord" = "";
 "ht_id" = 6;
 "ht_option" =             (
 );
 "ht_order" = 0;
 "ht_title" = "\U4e3b\U89c2\U9898";
 "ht_type" = 4;
 "hw_id" = 3;
 isCheck = 1;
 isSub = 1;
 }
 */
