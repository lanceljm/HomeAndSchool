//
//  HSLoginController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit


class HSLoginController: UIViewController {
    
    //账号
    @IBOutlet weak var accountTF: UITextField!
    //密码
    @IBOutlet weak var passwordTF: UITextField!
    //登录按钮
    @IBOutlet weak var loginBtn: UIButton!
    
    //账号
    var alertAccountVC = UIAlertController()
    //密码
    var alertPasswordVC = UIAlertController()
    
    //活动指示器
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
    func setupUI() {
        //程序员默认登录状态
        accountTF.text = "5110"
        passwordTF.text = "123456"
        
        //设置textfield里的图片
        accountTF.leftView = setLeftView(imageName: "icon_user")
        //一定要设置这个值，因为leftView的默认值是UITextFieldViewModeNever，是不会被设置的
        accountTF.leftViewMode = .always
        passwordTF.leftView = setLeftView(imageName: "icon_password")
        passwordTF.leftViewMode = .always
        
        passwordTF.isSecureTextEntry = true//设置密文
        
        //设置登录按钮的圆角
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
     
        //设置边框
        loginBtn.layer.borderWidth = 2
        let bordeWithColor = UIColor(red: 54/255.0, green: 147/255.0, blue: 1.0, alpha: 1.0)
        loginBtn.layer.borderColor = bordeWithColor.cgColor
        
    }
    
    //自定义textfield里面的图片（textfield本身是带有添加图片的接口的）
    func setLeftView(imageName:String) -> UIView{
        //创建背景视图存放前边两张图片
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        //获取图片
        let image = UIImage(named: imageName)
        
        //创建第一张图片视图
        let firstView = UIImageView(image: UIImage(named: imageName))
        firstView.center = CGPoint(x: (image?.size.width)!/2 + 8, y: 22)
        bgView.addSubview(firstView)
        
        //第二张图片
        let secondView = UIImageView(image: UIImage(named: "line_edit_sep"))
        secondView.center = CGPoint(x: firstView.frame.maxX + 10, y: 22)
        bgView.addSubview(secondView)
        
        return bgView
        
    }
    
    ///登录按钮的监听回调方法
    @IBAction func loginBtnClicked() {
        //1、登录前需要确定IP是否设置或是否正确
        guard baseURLString == nil || baseURLString == "http://120.24.57.38/new/" else {
            print("请正确输入你学校的IP")
            
            //自定义弹窗
            let alertVC = UIAlertController(title: "IP❌", message: "请输入正确的IP地址", preferredStyle: .alert)
            //添加textfield修改IP
            alertVC.addTextField(configurationHandler: { (textF) in
                textF.placeholder = "IP地址"
                
                //从单例获取上次输入的ip
                let ipString = UserDefaults.standard.object(forKey: IPSaveKey)
                textF.text = ipString as? String
            })
            alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
                //获得当前输入的内容
                let inputString = alertVC.textFields?[0].text
                //给单例赋值
                UserDefaults.standard.set(inputString, forKey: IPSaveKey)
            }))
            alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
            return
        }
        //2、判断账号是否为空或是否正确
        guard accountTF.text != "" else {
            print("账号不能为空")
            alertAccountVC = UIAlertController(title: "❎", message: "账号不能为空", preferredStyle: .alert)
            
            //动画
            present(alertAccountVC, animated: true, completion: nil)
            
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
            
            return
        }
        //3、判断密码是否为空或是否正确
        guard passwordTF.text != "" else {
            print("密码不能为空")
            alertPasswordVC = UIAlertController(title: "❌", message: "密码不能为空", preferredStyle: .alert)
            present(alertPasswordVC, animated: true, completion: nil)
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
            
            return
        }
        
        print("一切准备就绪，可以发送数据")
        //MARK:开始活动指示器，加载网络
        activity.startAnimating()
        
        //获得网络接口
        let urlString = "ZH-schoolname-S-login"
        //设置参数
        let parm = ["code":accountTF.text!,"password":passwordTF.text!]
        
        //调用网络单例方法获取数据
        HSAFNWorkTools.shared.request(url: urlString, parameters: parm) { (data, err) in
            //请求到数据，关闭活动指示器
            self.activity.stopAnimating()
            //判断数据是否为空
            guard let data = data as? NSDictionary else {
                print("登录失败，请检查网络")
                return
            }
            //判断账号密码正误
            let result = data["result"] as! Int
            switch result {
            case 0:
                print("设置登录")
                //获取用户信息字典
                let userInfo = data["data"] as! NSDictionary
                //保存数据到单例
                UserDefaults.standard.set(userInfo, forKey: userInfoKey)
                //设置页面跳转
                UIApplication.shared.keyWindow?.rootViewController = HSDrawerController()
                //保存登录状态
                
            case 1:
                print("提示错误")
            default:
                break
            }
        }
        
    }

    //设置按钮的监听回调方法
    @IBAction func setupBtnClicked() {
        //创建弹窗
        let alertVC = UIAlertController(title: "", message: "请输入学校的IP:", preferredStyle: .alert)
        alertVC.addTextField { (textF) in
            textF.placeholder = "学校IP地址"
            
            //保存上次输入的IP
            //MARK:从单例中获取
            let ipString = UserDefaults.standard.object(forKey: IPSaveKey)
            
            textF.text = ipString as? String
        }
        //确定
        alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let yourInputIP = alertVC.textFields?.first?.text
            //记录textfield内输入的值，保存到单例中,注意单例中修改一次作用全局
            //MARK:保存到单例中，给单例赋值
            UserDefaults.standard.set(yourInputIP, forKey: IPSaveKey)
        }))
        //取消
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        //退出弹窗
        present(alertVC, animated: true, completion: nil)
    }
    
    //点击屏幕结束编辑
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //账号或密码
    func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    //等待视图加载完成后才能加载活动指示器
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activity.center = CGPoint(x: screenW/2, y: passwordTF.frame.maxY + 15)
        view.addSubview(activity)
    }
    
    deinit {
        print("HSLoginController消失了")
    }
    
}
