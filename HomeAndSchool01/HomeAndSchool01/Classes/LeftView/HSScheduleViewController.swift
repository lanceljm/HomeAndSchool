//
//  HSScheduleViewController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/24.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScheduleViewController: UIViewController {

    //每个day的宽度
    let labelWidth:CGFloat = screenW/8
    
    let labelHeight:CGFloat = 44
    
    //创建一个集合视图
    var collectionView:UICollectionView!
    
    //创建一个保存课表数据的数据源数组
    var dataArr = [HSScheduleModel]()
    
    //网络错误弹窗
    var alertVC = UIAlertController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithHex(hexColor: 0xf0f0f0)
        
        setNavTopView()//导航栏
        setDaysView()//星期
        setCollectionView()
        setClassNumberView()//设置课的节节数
        downLoadClassData()//加载网络数据
        
    }
    //加载网络数据
    func downLoadClassData() {
        //获取接口地址
        let urlString = "ZH-schoolname-S-curriculum"
        //设置参数
        let parm = ["key":userID]
        //请求网络数据
        HSAFNWorkTools.shared.request(url: urlString, parameters: parm) { [weak self] (data, err) in
            //判断网络是否异常
            guard let data = data as? NSDictionary ,
                let dictArr = data["data"] as? [NSDictionary] else {
//                     alertVC = UIAlertController(title: "⚠️", message: "网络开小差了", preferredStyle: .alert)
//                    present(alertVC, animated: true, completion: nil)
//                    _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(closeAlert), userInfo: nil, repeats: false)
//                    
                    print("网络错误")
                    return
            }
            //遍历数组
            for dict in dictArr {
                //获取当前字典中所有的key，并排序
                let keys = (dict.allKeys as! [String]).sorted()
                //遍历keys数组，获得对应的字典
                for k in keys {
                    //根据遍历的key获取字典
                    let classDict = dict[k] as! [String:String]
                    //字典转模型
                    let classModel = HSScheduleModel(dic: classDict)
                    //保存到数组中
                    self?.dataArr.append(classModel)
                    //处理午休状态
                    if k == "c4" {
                        let emptyM = HSScheduleModel(dic: [:])
                        self?.dataArr.append(emptyM)
                    }
                }
            }
            //刷新视图
            self?.collectionView.reloadData()
        }
    }
    
    //关闭弹窗
    func closeAlert() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:UI-相关设置
extension HSScheduleViewController {
    //设置导航栏
    func setNavTopView() {
        //使用uiview来嵌套
        let naviView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        naviView.backgroundColor = UIColor.colorWithHex(hexColor: 0x009ee7)
        view.addSubview(naviView)
        
        //添加返回按钮的文字和图片
        let backBtn = UIButton(type:.custom)
        backBtn.frame = CGRect(x: 0, y: 20, width: screenW, height: 44)
        backBtn.setTitle("课表", for: .normal)
        backBtn.setImage(UIImage(named:"leftBtnBullet"), for: .normal)
        //整体左移(在左侧)
        backBtn.contentHorizontalAlignment = .left
        //文字、图片的偏移
        /*图片和文字是按钮默认属性的接口，不是自定义*/
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        naviView.addSubview(backBtn)
        
    }
    
    func backBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //添加星期i视图
    func setDaysView() {
        //设置文字数组
        let titleArr = ["一","二","三","四","五","六","日"]
        
        //循环添加数字
        for (i,day) in titleArr.enumerated() {
            let label = UILabel(title: day, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), fontsize: 15)
            label.frame = CGRect(x: CGFloat(i + 1)*labelWidth, y: labelHeight + 20, width: labelWidth, height: labelHeight)
            view.addSubview(label)
        }
        
    }
    
    //添加课数，第几节
    func setClassNumberView() {
        for item in 1 ... 10 {
            if item == 5 {
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: 0, y: 64 + CGFloat(item)*labelHeight, width: screenW, height: labelHeight)
                btn.setTitle("午 休", for: .normal)
                btn.setBackgroundImage(UIImage(named:"curriculum_wuxiu_bg"), for: .normal)
                view.addSubview(btn)
            }else {
                let label = UILabel(title:item > 4 ? "\(item-1)":"\(item)", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), fontsize: 15)
                label.frame = CGRect(x: 0, y: CGFloat(item)*labelHeight + 64, width: labelWidth, height: labelHeight)
                view.addSubview(label)
            }
            //自定义分割线
            let lineWidth = UIView(frame: CGRect(x: 5, y: 64 + CGFloat(item - 1)*labelHeight + labelHeight, width: screenW - 10, height: 1))
            lineWidth.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            view.addSubview(lineWidth)
            
            //午休前
            let lineHeightUP = UIView(frame:CGRect(x: CGFloat(item)*labelWidth, y: 64, width: 1, height: labelHeight*5))
            lineHeightUP.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            view.addSubview(lineHeightUP)
            //午休后
            let lineHeightDOWN = UIView(frame: CGRect(x: CGFloat(item)*labelWidth, y: 64 + labelHeight*6, width: 1, height: labelHeight*5))
            lineHeightDOWN.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            view.addSubview(lineHeightDOWN)
            
        }
    }
    
    //集合视图显示课程内容
    func setCollectionView() {
        let rect = CGRect(x: labelWidth, y:labelHeight + 64, width: labelWidth*7, height: labelHeight*9)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: labelWidth, height: labelHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //uicollectionview的滚动方向
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //必须在添加到视图之前注册cell
        collectionView.register(HSScheduleCell.self, forCellWithReuseIdentifier: "classCell")
        view.addSubview(collectionView)
    }
    
}

//MARK:uicollectionview相关
extension HSScheduleViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HSScheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath) as! HSScheduleCell
        
        let classModel = dataArr[indexPath.item]
        cell.model = classModel
        return cell
    }
}
