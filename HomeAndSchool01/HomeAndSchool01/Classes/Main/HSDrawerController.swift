//
//  HSDrawerController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/23.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSDrawerController: UIViewController {

    //MARK:属性
    ///声明左边视图,从storyboard中获得，注意添加ID
    let leftVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSLeftViewController")
    //设置左边视图的宽度
    let leftViewWidth:CGFloat = screenW*0.842
    //设置左边视图的最大偏移量
    let leftViewMaxOffSet:CGFloat = screenW/2
    
    ///声明右边视图,是tabbar
    let tabbarVC = HSTabBarController()
    
    //抽屉的动画时长
    let animationTime:TimeInterval = 0.5
    
    
    //MARK:懒加载遮盖视图
    lazy var coverView:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = UIScreen.main.bounds
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.alpha = 0.2
        return btn
    }()
    
    
    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        setupUI()
        addGesture()
    }
    
    //MARK:方法实现
    //MARK:设置UI
    func setupUI()  {
        //MARK:抽屉左边
        //添加左边控制器
        addChildViewController(leftVC)
        //添加控制器作为子控制器时必须添加视图作为子视图
        view.addSubview(leftVC.view)
        leftVC.view.frame = CGRect(x: 0, y: 0, width: leftViewWidth, height: screenH)
        //设置左边视图的右侧阴影
        leftVC.view.layer.shadowColor = UIColor.black.cgColor/*注意阴影颜色是cgcolor*/
        leftVC.view.layer.shadowOpacity = 1.0
        leftVC.view.layer.shadowOffset = CGSize(width: 3, height: 0)
        //设置默认的形变属性
        leftVC.view.transform = CGAffineTransform(translationX: -leftViewMaxOffSet, y: 0)
        
        //MARK:抽屉右边
        //添加右边控制器
        addChildViewController(tabbarVC)
        //添加控制器作为子控制器时必须添加视图作为子视图
        view.addSubview(tabbarVC.view)
        
        //给coverview赋值
        tabbarVC.leftBtnClick = { [weak self] in
            if (self?.tabbarVC.view.transform.tx)! > 0 {
                self?.closeAnimation()
            }else{
                self?.openAnimate()
            }
        }
        
    }
    
    //MARK:添加手势
    func addGesture() {
        //添加拖动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureChange(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    //MARK:手势的回调方法
    func panGestureChange(gesture:UIPanGestureRecognizer)  {
        
    }
    
    //MARK:打开抽屉的方法
    func openAnimate() {
        //添加遮盖视图
        tabbarVC.view.addSubview(coverView)
        //给遮盖时的“视图”添加事件
        coverView.addTarget(self, action: #selector(closeAnimation), for: .touchUpInside)
        //移动标签控制器视图
        UIView.animate(withDuration: animationTime) { [weak self] in
            self?.tabbarVC.view.transform = CGAffineTransform(translationX: (self?.leftViewWidth)!, y: 0)
            self?.leftVC.view.transform = CGAffineTransform.identity
        }
    }
    
    //MARK:关闭抽屉的方法
    func closeAnimation() {
        //让左边视图的偏移回复到初始值
        UIView.animate(withDuration: animationTime, animations: { 
            self.tabbarVC.view.transform = CGAffineTransform.identity//恢复到初始值
            self.leftVC.view.transform = CGAffineTransform(translationX: -(self.leftViewMaxOffSet), y: 0)
        }) { (_) in
            self.coverView.removeFromSuperview()
        }
    }
}
