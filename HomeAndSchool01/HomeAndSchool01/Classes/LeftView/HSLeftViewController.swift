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
    
    //头像
    @IBOutlet weak var leftIconImage: UIImageView!
    
    //姓名
    @IBOutlet weak var leftStuName: UILabel!
    //账号
    @IBOutlet weak var leftAccount: UILabel!
    
    //班级
    @IBOutlet weak var leftClass: UILabel!
    
    //学校
    @IBOutlet weak var leftSchool: UILabel!
    
    //表现分
    @IBOutlet weak var leftScore: UILabel!
    
    //表现状况
    @IBOutlet weak var leftImageBgView: UIView!
    
    //获得保存的属性
    let userinfo = UserDefaults.standard.object(forKey: userInfoKey) as! NSDictionary
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupUI()
     
    }
    //MARK:设置UI
    func setupUI() {
        //MARK:上方的蓝色背景视图
       
        //蓝色背景视图
        var blueView = UIView()
        blueView = blueHeadView
        blueView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(blueView)
        
        //树状图背景
        leftImageBgView.backgroundColor = UIColor.colorWithHex(hexColor: 0x09ee7)
        blueView.addSubview(leftImageBgView)
        
        //头像
        leftIconImage.layer.cornerRadius = leftIconImage.frame.size.width/2
        leftIconImage.layer.masksToBounds = true
        
        leftIconImage.layer.borderWidth = 2
        let borderWithColor = UIColor.white.cgColor
        leftIconImage.layer.borderColor = borderWithColor
        
        //MARK:赋值信息参数
        //获取图片的加密字符串
        if let base64Str = userinfo["studentphoto"] as? String,
            //将加密字符串转换为二进制
            let imageData = Data(base64Encoded: base64Str, options: Data.Base64DecodingOptions.ignoreUnknownCharacters){
            //给头像赋值
            leftIconImage.image = UIImage(data: imageData)
        }
        //名字
        let studentName = userinfo["studentName"] as? String
        leftStuName.text = "\(studentName ?? "") 家长"
        //账号
        leftAccount.text = userinfo["studentNum"] as? String
        //班级
        leftClass.text = userinfo["classname"] as? String
        //学校
        leftSchool.text = userinfo["schoolname"] as? String
        //分数
        leftScore.text = userinfo["studentScore"] as? String
        
        let score = Int(leftScore.text ?? "") ?? 0
        var scoreRange = 0
        //使用switch给分数的树状图赋值
        switch score {
        case 0 ..< 10:
            scoreRange = 0
        case 10 ..< 50:
            scoreRange = 1
        case 50 ..< 150:
            scoreRange = 2
        case 150 ..< 350:
            scoreRange = 3
        case 350 ..< 850:
            scoreRange = 4
        default:
            scoreRange = 5
        }
        //循环添加
        for item in 1 ... 5 {
            //初始化一张图片
            var imageName = ""
            if item <= scoreRange {
                imageName = "jujube\(item)_light"
            }else {
                imageName = "jujube\(item)_dark"
            }
            let imageView = UIImageView(image: UIImage(named: imageName))
            //添加到背景视图
            leftImageBgView.addSubview(imageView)
        }
        
        
        
        //MARK:设置下边的按钮
        //课表
        scheduleBtn.tag = 100
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
            present(HSScheduleViewController(), animated: true, completion: nil)
            /*
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
            */
        case 101:
            let aboutUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSAboutUsViewController")
            present(aboutUsVC, animated: true, completion: nil)
            /*
            let aboutusVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSAboutUsViewController")
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "关于我们", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 24),NSForegroundColorAttributeName:UIColor.white], for: .normal)
            aboutusVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]
            let  naviVC = HSNavigationController(rootViewController: aboutusVC)
            present(naviVC, animated: true, completion: nil)
            */
        case 102:
            let feedbackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSFeedBackViewController")
            present(feedbackVC, animated: true, completion: nil)
            
            /*
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "意见反馈", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 24)], for: .normal)
            feedbackVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]

            let naviVC = HSNavigationController(rootViewController: feedbackVC)
             */
            
        case 103:
            present(HSSetUpViewController(), animated: true, completion: nil)
            /*
            let setupVC = HSSetUpViewController()
            let image = UIImage(named: "leftBtnBullets")?.withRenderingMode(.alwaysOriginal)
            let leftBtnImage = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(clickedBack))
            let leftBtnTitle = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(clickedBack))
            leftBtnTitle.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 24),NSForegroundColorAttributeName:UIColor.white], for: .normal)
            setupVC.navigationItem.leftBarButtonItems = [leftBtnImage,leftBtnTitle]
            let naviVC = HSNavigationController(rootViewController: setupVC)
            present(naviVC, animated: true, completion: nil)
            */
        case 104:
//            let loginVC = HSLoginController()
            break
        
            
        default:
            break
        }
        //将颜色转换为图片
        sender.setBackgroundImage(UIImage.image(withColor: UIColor(white: 0.9, alpha: 1.0)), for: .highlighted)
    }
    
    //课表等界面退出的监听事件
    func clickedBack() {
        dismiss(animated: true, completion: nil)
    }
    
    //树状图的分布
    override func viewDidAppear(_ animated: Bool) {
        //计算平均间距
        let magin = leftImageBgView.frame.width/5
        print(leftImageBgView.frame.width)
        //获得背景视图的高度
        let bottomY = leftImageBgView.frame.height
        print(leftImageBgView.subviews)
        for (i,v) in leftImageBgView.subviews.enumerated() {
            v.center = CGPoint(x: magin/2 + CGFloat(i)*magin, y: bottomY - v.frame.height/2)
        }
        
        
    }
}
