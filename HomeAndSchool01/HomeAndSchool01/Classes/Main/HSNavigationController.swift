//
//  HSNavigationController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/23.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航条背景色
        navigationBar.barTintColor = UIColor.colorWithHex(hexColor: 0x009ee7)/*自定义颜色*/
        
        //设置标题的属性
        navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont .systemFont(ofSize: 24),NSForegroundColorAttributeName:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
}
