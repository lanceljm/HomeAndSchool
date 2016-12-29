//
//  HSSetUpViewController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/24.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSSetUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        setNaviView()
    }
}

extension HSSetUpViewController {
    func setNaviView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        topView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(topView)
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: screenW, height: 44))
        backBtn.setImage(UIImage(named:"leftBtnBullets"), for: .normal)
        backBtn.setTitle("设置", for: .normal)
        
        backBtn.contentHorizontalAlignment = .left
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        topView.addSubview(backBtn)
    }
    func backBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
}
