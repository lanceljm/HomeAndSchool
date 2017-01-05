//
//  HSHomeworkObjModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
//客观题模型
class HSHomeworkObjModel: NSObject {

    //题目
    var ht_title:String?
    
    var ht_correctWord:String?
    var ht_id:Int = 0
    //题目id
//    var ho_id:Int = 0
    
    //选项
//    var ho_text:String?
    //题目序号
    var ht_order:Int = 0
    //题目类型
    var ht_type:Int = 0
    var hw_id:Int = 0
    var isCheck:Int = 0
    var isSub:Int = 0
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
 "ht_correctWord" = A;
 "ht_id" = 4;
 "ht_option" =             (
 {
 "ho_id" = 11;
 "ho_text" = "A:\U9009\U98791";
 "ht_id" = 4;
 },
 {
 "ho_id" = 12;
 "ho_text" = "B:\U9009\U98792";
 "ht_id" = 4;
 },
 {
 "ho_id" = 13;
 "ho_text" = "C:\U9009\U98793";
 "ht_id" = 4;
 },
 {
 "ho_id" = 14;
 "ho_text" = "D:\U9009\U98794";
 "ht_id" = 4;
 }
 );
 "ht_order" = 0;
 "ht_title" = "\U5355\U9009\U9898";
 "ht_type" = 1;
 "hw_id" = 2;
 isCheck = 1;
 isSub = 1;
 },
 */
