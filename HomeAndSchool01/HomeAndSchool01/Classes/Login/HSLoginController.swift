//
//  HSLoginController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit
let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height

class HSLoginController: UIViewController {
    
    var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        addLoginBtn()
    }
    func addLoginBtn() {
        loginBtn = UIButton(type: .custom)
        loginBtn.frame = CGRect(x: 0, y: 0, width: WIDTH*0.3, height: HEIGHT*0.2)
        loginBtn.center = CGPoint(x: WIDTH/2, y: HEIGHT/2)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        view.addSubview(loginBtn)
    }
    
    ///登录事件///登录按钮的监听回调方法
    func loginBtnClicked() {
        
        ///获得主窗口，重置根页面
        UIApplication.shared.keyWindow?.rootViewController = HSTabBarController()
        print("登录")
    }
    deinit {
        print("HSLoginController消失了")
    }
    
}
