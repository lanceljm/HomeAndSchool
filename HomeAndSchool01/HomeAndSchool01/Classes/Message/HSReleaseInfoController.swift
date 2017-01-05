//
//  HSReleaseInfoController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/30.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSReleaseInfoController: UIViewController {
    
    @IBOutlet weak var customTitleTF: UITextField!
    
    @IBOutlet weak var customTextView: UITextView!
    
    @IBOutlet weak var customPlacerLabel: UILabel!

    @IBOutlet weak var customRemoveAllBtn: UIButton!
    
    @IBOutlet weak var customSubmitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviTopView()
        setupUI()
    }
    
    func setupUI() {
        customTextView.delegate = self
        
        customRemoveAllBtn.isHidden = true
        
        customSubmitBtn.layer.cornerRadius = 5
        customSubmitBtn.layer.masksToBounds = true
    }
    
    //删除
    @IBAction func removeBtnClicked(_ sender: UIButton) {
        customTextView.text = ""
        customRemoveAllBtn.isHidden = true
        customPlacerLabel.isHidden = false
    }
    
    //提交
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        //输入的内容
        let title = customTitleTF.text
        let content = customTextView.text
        
        if title == "" {
            HSAlertView.bottomAlertView("标题不能为空")
            return
        }
        if content == "" {
            HSAlertView.bottomAlertView("内容不能为空")
            return
        }
        
        view.endEditing(true)
        
        //MARK:上传信息
        //获得上传端口
        let urlStr = "ZH-schoolname-S-submitJXMessage"
        //用户输入的信息
        let parm = ["key":userID,"title":title!,"content":content!]
        //给服务器发送消息
        HSAFNWorkTools.shared.request(url: urlStr, parameters: parm) { (data, err) in
            if err == nil {
                HSAlertView.bottomAlertView("消息上传失败")
                self.customPlacerLabel.isHidden = false
            }else {
                HSAlertView.bottomAlertView("消息上传成功")
                self.customPlacerLabel.isHidden = true
            }
            self.customTitleTF.text = nil
            self.customTextView.text = nil
        }
        customRemoveAllBtn.isHidden = true
    }
}

//MARK:遵守uitextview的代理
extension HSReleaseInfoController:UITextViewDelegate {
    //编辑状态发生改变
    func textViewDidChange(_ textView: UITextView) {
        if customTextView.text != "" {
            customPlacerLabel.isHidden = true
            customRemoveAllBtn.isHidden = false
        }else {
            customPlacerLabel.isHidden = false
            customRemoveAllBtn.isHidden = true
        }
    }
}

//MARK:UI相关
extension HSReleaseInfoController {
    //导航条
    func setNaviTopView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        topView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(topView)
        
        //添加一个按钮，当成导航栏的返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: screenW, height: 44))
        backBtn.setImage(UIImage(named:"leftBtnBullets"), for: .normal)
        backBtn.setTitle("消息", for: .normal)
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

