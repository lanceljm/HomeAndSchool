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
    
    //记录手势开始的位置
    var startPoint:CGPoint = CGPoint()
    
    //计算偏移距离的比例
    var scaleOffSet:CGFloat {
        return leftViewMaxOffSet/(leftViewWidth + 3)
    }
    
    //遮盖时刻的透明度
    let coverViewAlpha:CGFloat = 0.8
    
    
    //MARK:懒加载遮盖视图
    lazy var coverView:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = UIScreen.main.bounds
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.alpha = 0.8
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
        
        //赋值闭包代码块
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
        //手势在使用的时候要注意手势的状态、手势的过程
        switch gesture.state {
        case .began:
            //手势的初始位置
            startPoint = gesture.location(in: gesture.view)
        case .changed:
            //获得当前手指的位置
            let offset = gesture.translation(in: gesture.view)
            //计算两个视图的偏移量
            let newOffSet = tabbarVC.view.transform.tx + offset.x
//            print("tabbar视图的偏移量：\(tabbarVC.view.transform.tx)")
//            print("当前手指位置的x:\(offset.x)")
            ///判断，当偏移量大于最大偏移量时打开视图
            if newOffSet >= leftViewMaxOffSet {
                openAnimate()
                return
            }
//            print("两个视图的偏移量：\(newOffSet)")
//            
//            print("左边视图的最大偏移量：\(leftViewMaxOffSet)")
            //当左边界越界时，当前偏移量小于0
            if newOffSet <= 0 {
                closeAnimation()
                return
            }
            //计算左边视图的偏移量
            let newOffSet_left = leftVC.view.transform.tx + offset.x*scaleOffSet
            
            //标签视图的偏移
            tabbarVC.view.transform = CGAffineTransform(translationX: newOffSet, y: 0)
            //左边视图的偏移
            leftVC.view.transform = CGAffineTransform(translationX: newOffSet_left, y: 0)
            
            //注意手势拖动是增加的偏移量时累加，最后必须恢复
            gesture.setTranslation(CGPoint(), in: gesture.view)
            
        case .ended:
            //获得结束手势的位置
            let endPoint = gesture.location(in: gesture.view)
            ///这里才是决定手势拖动是否执行动画的地方
            if endPoint.x > leftViewMaxOffSet/*startPoint.x */{
                openAnimate()
            }else{
                closeAnimation()
            }
            
        default:
            break
        }
        
    }
    
    //MARK:打开抽屉的方法
    func openAnimate() {
        //添加遮盖视图
        tabbarVC.view.addSubview(coverView)
        //给遮盖时的“视图”添加事件
        coverView.addTarget(self, action: #selector(closeAnimation), for: .touchUpInside)
        //移动标签控制器视图
        UIView.animate(withDuration: animationTime) { [weak self] in
            self?.tabbarVC.view.transform = CGAffineTransform(translationX: (self?.leftViewWidth)! + 3, y: 0)
            self?.leftVC.view.transform = CGAffineTransform.identity
            //设置遮盖视图的透明度
            self?.coverView.alpha = 0.6
        }
    }
    
    //MARK:关闭抽屉的方法
    func closeAnimation() {
        //让左边视图的偏移回复到初始值
        UIView.animate(withDuration: animationTime, animations: { 
            self.tabbarVC.view.transform = CGAffineTransform.identity//恢复到初始值
            self.leftVC.view.transform = CGAffineTransform(translationX: -(self.leftViewMaxOffSet), y: 0)
            //设置透明度，使视图在点击关闭按键时就透明，而不是视图被移除时才透明
            self.coverView.alpha = 0.0
        }) { (_) in
            self.coverView.removeFromSuperview()
        }
    }
}
