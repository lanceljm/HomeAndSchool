//
//  HSFeedBackViewController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/24.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSFeedBackViewController: UIViewController {

    //删除按钮
    @IBOutlet weak var customTextBtn: UIButton!
    //文本标题
    @IBOutlet weak var customTitleTextfield: UITextField!
    //UITextView
    @IBOutlet weak var customTextView: UITextView!
    //自定义水印文字
    @IBOutlet weak var customLabel: UILabel!
    //提价按钮
    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviTopView()//设置导航条
        setupUI()
    
    }
    
    func setupUI() {
        customTextView.delegate = self
        customTextBtn.isHidden = true
        
        submitBtn.layer.cornerRadius = 5
        submitBtn.layer.masksToBounds = true
    }
    //删除按钮的事件
    @IBAction func customTextViewBtn(_ sender: Any) {
        customTextView.text = ""
        customLabel.isHidden = false
        customTextBtn.isHidden = true
    }
    
    //提交按钮
    @IBAction func submitBtnClicked() {
        //获取输入的内容
        let title = customTitleTextfield.text
        let content = customTextView.text
        
        if title == "" {
            HSAlertView.bottomAlertView("标题不能为空")
            return
        }
        
        if content == "" {
            HSAlertView.bottomAlertView("上传内容不能为空")
            return
        }
        
        //退出编辑模式
        view.endEditing(true)
        //MARK:上传信息
        //获取发送接口
        let urlString = "ZH-schoolname-S-submitJXOpinion"
        //用户输入信息
        let feedbackInfo = ["key":userID,"title":title!,"content":content!]
        //发送消息
        HSAFNWorkTools.shared.request(url: urlString, parameters: feedbackInfo) { (data, err) in
            if err != nil {
                HSAlertView.bottomAlertView("消息发送失败")
                self.customLabel.isHidden = true
            }else {
                HSAlertView.bottomAlertView("消息发送成功")
                self.customLabel.isHidden = false
            }
            self.customTextView.text = nil
            self.customTitleTextfield.text = nil
        }
        customTextBtn.isHidden = true
    }
    
    
}

//MARK:遵守代理
extension HSFeedBackViewController:UITextViewDelegate {
    //编辑状态发生改变
    func textViewDidChange(_ textView: UITextView) {
        if customTextView.text != "" {
            customLabel.isHidden = true
            customTextBtn.isHidden = false
        }else {
            customLabel.isHidden = false
            customTextBtn.isHidden = true
        }
    }
}

//MARK:UI相关
extension HSFeedBackViewController {
    //导航条
    func setNaviTopView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        topView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(topView)
        
        //添加一个按钮，当成导航栏的返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: screenW, height: 44))
        backBtn.setImage(UIImage(named:"leftBtnBullets"), for: .normal)
        backBtn.setTitle("意见反馈", for: .normal)
        backBtn.contentHorizontalAlignment = .left
        //偏移调整图片和文字的位置
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        topView.addSubview(backBtn)
    }
    
    func backBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
}
