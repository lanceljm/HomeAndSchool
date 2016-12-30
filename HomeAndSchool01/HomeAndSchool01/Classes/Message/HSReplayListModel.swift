//
//  HSReplayListModel.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/30.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSReplayListModel: NSObject {
    
    var int_content:String?
    var int_name:String?
    var user_type:Int = 0
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}


/*
 
 var int_content:String?
 var int_name:String?
 var user_type:Int = 0
 
 */
