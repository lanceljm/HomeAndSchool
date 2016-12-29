//
//  HSAboutUsViewController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/24.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSAboutUsViewController: UIViewController {

    @IBOutlet weak var customUIView: UIView!
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setNaviTopView()
    }
}

//MARK:UI相关
extension HSAboutUsViewController {
    //导航条
    func setNaviTopView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        topView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(topView)
        
        //添加一个按钮，当成导航栏的返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: screenW, height: 44))
        backBtn.setImage(UIImage(named:"leftBtnBullets"), for: .normal)
        backBtn.setTitle("关于我们", for: .normal)
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
