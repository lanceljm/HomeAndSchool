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
        
        customTextViewDelegate()
    
    }
    //设置uiview相关的属性
    func customTextViewDelegate() {
        customTextView.delegate = self
        customTextBtn.alpha = 0
        if customTextView.text.isEmpty {
            customLabel.isHidden = false
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
