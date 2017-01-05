//
//  HSTabBarController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSTabBarController: UITabBarController {

    //传递左边按钮的闭包属性
    var leftBtnClick:(() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        //设置标签控制器的文字颜色
        tabBar.tintColor = UIColor.colorWithHex(hexColor: 0x00a0e9)///十六进制的数要在前边加上0x
        
        ///模拟网路数据加载
        /*模拟网络下载，获取自定义子控制器的相关设置文件*/
        guard let filePath = Bundle.main.path(forResource: "tabar", ofType: "plist") ,
            let disArr = NSArray(contentsOfFile: filePath)
            else {
            return
        }
        ///添加子控制器，一次添加，有顺序
        for dic in disArr {
            //使用自定义的方法根据传入的字典来初始化
            addChildVC(dic as! NSDictionary)
        }
    }
    
    ///重载添加子控制器的方法/*注意重载和重写的区别,重载一定要加override关键字*/
    func addChildVC(_ dic:NSDictionary) {
        //获取命名空间
        guard let bundleName = Bundle.main.bundleName ,/*从延展的方法中获得*/
        //获取字典中的控制器名字
            let vcString = dic["vc"] as? String ,
        ///反射机制，类转换为字符串
            let classVC = NSClassFromString("\(bundleName).\(vcString)") as? UIViewController.Type ,
        //获得图片名称
            let imageName = dic["imageName"] as? String
        else {
            return
        }
        
        //根据转换的类型初始化，获得相应的控制器
        let vc = classVC.init()
        
        vc.title = dic["title"] as? String
        vc.tabBarItem.image = UIImage(named: "\(imageName)_nor")
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_press")?.withRenderingMode(.alwaysOriginal)/*渲染，使图片保持原色*/
        
        //添加左侧侧滑按钮
        let leftBtn = UIBarButtonItem(imageName: "icon_menu", taget: self, action: #selector(leftBtnClicked))
        vc.navigationItem.leftBarButtonItem = leftBtn
        
        //包装一个导航控制器
        let naviVC = HSNavigationController(rootViewController: vc)
        addChildViewController(naviVC)
        
    }
    
    func leftBtnClicked() {
        UIApplication.shared.keyWindow?.endEditing(true)
        
        //执行闭包，传递事件
        leftBtnClick?()
    }
}
