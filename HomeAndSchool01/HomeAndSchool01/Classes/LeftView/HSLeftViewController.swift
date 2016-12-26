//
//  HSLeftViewController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/23.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSLeftViewController: UIViewController {

    //蓝色背景视图
    @IBOutlet weak var blueHeadView: UIView!
    //MARK:按钮

    @IBOutlet weak var scheduleBtn: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var setupBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupUI()
     
    }
    //MARK:设置UI
    func setupUI() {
        //蓝色背景视图
        var blueView = UIView()
        blueView = blueHeadView
        blueView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(blueView)
        
        //头像
        //姓名
        
        //课表
        scheduleBtn.tag = 100
        scheduleBtn.setBackgroundImage(nil, for: .highlighted)
        scheduleBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        //关于我们
        aboutUsBtn.tag = 101
        aboutUsBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        //意见反馈
        feedbackBtn.tag = 102
        feedbackBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        //设置
        setupBtn.tag = 103
        setupBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        //退出
        logoutBtn.tag = 104
        logoutBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        
    }
    
    //按钮监听事件
    func btnClicked(sender:UIButton) {
        switch sender.tag {
        case 100:
           let scheduleVC = HSScheduleViewController()
           //返回按钮的图片
           //渲染图片
           let image = UIImage(named:"leftBtnBullet")?.withRenderingMode(.alwaysOriginal)
           let leftBtnImage = UIBarButtonItem(image:image, style: .plain, target: self, action: #selector(clickedBack))
           //返回按钮的文字
           let leftBtnTitle = UIBarButtonItem(title: "课表", style: .plain, target: self, action: #selector(clickedBack))
           //设置文字属性
           leftBtnTitle.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 24)], for: .normal)
           //将组合键添加到导航条上
           scheduleVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]
           //使用自定义导航条
           let naviVC = HSNavigationController(rootViewController: scheduleVC)
           //使用模态推送
            present(naviVC, animated: true, completion: nil)
        case 101:
            let aboutusVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSAboutUsViewController")
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "关于我们", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 24),NSForegroundColorAttributeName:UIColor.white], for: .normal)
            aboutusVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]
            let  naviVC = HSNavigationController(rootViewController: aboutusVC)
            present(naviVC, animated: true, completion: nil)
            
        case 102:
            let feedbackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSFeedBackViewController")
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "意见反馈", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 24)], for: .normal)
            feedbackVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]

            let naviVC = HSNavigationController(rootViewController: feedbackVC)
            present(naviVC, animated: true, completion: nil)
        case 103:
            let setupVC = HSSetUpViewController()
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 24),NSForegroundColorAttributeName:UIColor.white], for: .normal)
            setupVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]
            let naviVC = HSNavigationController(rootViewController: setupVC)
            present(naviVC, animated: true, completion: nil)
            
        case 104:
//            let loginVC = HSLoginController()
            break
        
            
        default:
            break
        }
    }
    
    //课表等界面退出的监听事件
    func clickedBack() {
        dismiss(animated: true, completion: nil)
    }
}
