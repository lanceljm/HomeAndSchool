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
    //UITextView
    @IBOutlet weak var customTextView: UITextView!
    //自定义水印文字
    @IBOutlet weak var customLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviTopView()//设置导航条
        customTextViewDelegate()
    
    }
    //设置uiview相关的属性
    func customTextViewDelegate() {
        customTextView.delegate = self
        
        customTextBtn.alpha = 0
        if customTextView.text.isEmpty {
            customLabel.alpha = 1.0
        }
    }
    //删除按钮的事件
    @IBAction func customTextViewBtn(_ sender: Any) {
        customTextView.text = nil
        customLabel.isHidden = false
        customTextBtn.isHidden = true
    }

}

extension HSFeedBackViewController:UITextViewDelegate {
    //开始编辑，隐藏label
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        customLabel.isHidden = true
        return true
    }
    //编辑状态发生变化
    func textViewDidChange(_ textView: UITextView) {
        if customTextView.text != nil {
            customLabel.isHidden = true
            customTextBtn.isHidden = false
            customTextBtn.alpha = 1.0
            
        }else{
            customLabel.isHidden = false
            customTextBtn.isHidden = true
            customTextBtn.alpha = 0
        }
    }

    //结束编辑，显示label
    func textViewDidEndEditing(_ textView: UITextView) {
        customLabel.isHidden = false
        customTextBtn.isHidden = false
        customTextBtn.alpha = 1.0
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
