//
//  HSMessageController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit
import MJRefresh

class HSMessageController: UITableViewController {
    
    //回复内容输入条
    var replayInputToolBar:UIView?
    //输入框
    var inputTextF:UITextField?
    
    //记录当前点击按钮的cell属性
    var currentCell = HSMessageCell()
    
    
    //使用列表模型加载数据
    let messagListModel = HSMessageListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注册
        tableView.register(UINib.init(nibName: "HSMessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")

        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        //添加右上角
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "release_msg", taget: self, action: #selector(rightBtnClicked))
        //注册通知，监听键盘是否弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notify:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        //MARK:添加刷新数据控件
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.downLoadData(refresh: .down)
        })
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            self?.downLoadData(refresh: .up)
        })
        tableView.mj_header.beginRefreshing()
    }
    
    func downLoadData(refresh:LoadType) {
        messagListModel.loadDate(refresh: refresh) {[weak self] (isOK) in
            if refresh == .down {
                self?.tableView.mj_header.endRefreshing()
            }else {
                self?.tableView.mj_footer.endRefreshing()
            }
            if isOK {
                self?.tableView.reloadData()
            }
        }
    }

    //设置回复设置输入条
    func setupReplayInputToolBar() {
        //创建输入工具条
        replayInputToolBar = UIView(frame: CGRect(x: 0, y: screenH - 300, width: screenW, height: 44))
        replayInputToolBar?.backgroundColor = UIColor.colorWithHex(hexColor: 0xf0f0f0)
        //创建文本输入框
        inputTextF = UITextField(frame: CGRect(x: 8, y: 2, width: screenW - 44 - 8, height: 40))
        inputTextF?.placeholder = "回复是一种鼓励！"
        inputTextF?.borderStyle = .roundedRect
        replayInputToolBar?.addSubview(inputTextF!)
        
        //确定按钮
        let sureBtn = UIButton(type: .system)
        sureBtn.frame = CGRect(x: screenW - 44, y: 0, width: 44, height: 44)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithHex(hexColor: 0x00a0e9), for: .normal)
        sureBtn.addTarget(self, action: #selector(replaySureBtnClicked), for: .touchUpInside)
        replayInputToolBar?.addSubview(sureBtn)
        UIApplication.shared.keyWindow?.addSubview(replayInputToolBar!)
    }
    
    func rightBtnClicked() {
        let releaseVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSReleaseInfoController")
        present(releaseVC, animated: true, completion: nil)
    }
}

//MARK:表格视图的数据源和代理
extension HSMessageController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! HSMessageCell
        cell.selectionStyle = .none
        
        let messageM = messagListModel.messageModels[indexPath.row]
        cell.messageVM = messageM
        
        //处理相应cell对应的事件
        //点赞
        cell.likeBtnBlock = {[weak self] (clickcell) in
            self?.likeBtnClicked(clickcell)
        }
        //回复
        cell.replyBtnBlock = {[weak self] (clickcell) in
            self?.replayBtnClicked(clickcell)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagListModel.messageModels.count
    }
    
    //拖动表格视图，移除键盘
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            quitKeyboard()
        }
    }
    
    //退出键盘
    func quitKeyboard() {
        inputTextF?.resignFirstResponder()//取消第一响应者
    }
}


//MARK:点赞和回复相关功能代码实现
extension HSMessageController {
    //点赞
    func likeBtnClicked(_ cell:HSMessageCell) {
        //获得当前cell对应的视图模型
        guard let messageVM = cell.messageVM ,let likeListStr = cell.messageVM?.message.likelist ,let userName = userInfo["studentName"] as? String else {
            return
        }
        let likeStr = (likeListStr as NSString).range(of: "\(userName) 家长")
        if likeStr.length > 0 {
            HSAlertView.bottomAlertView("已点赞")
            return
        }
        
        
        //获得点赞接口
        let likeURL = "ZH-schoolname-S-submitJXLike"
        //获得学生通知id
        let Studentnotification_id = messageVM.message.not_id
        //设置参数
        let parm:[String:Any] = ["key":userID,"id":Studentnotification_id,"user_type":2]
        
        //提交服务器
        HSAFNWorkTools.shared.request(url: likeURL, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary ,let dictArr = data["data"] as? [[String:Any]] else {
                HSAlertView.bottomAlertView("点赞异常")
                return
            }
            //获得点赞后的数据
            let likeNewStr = dictArr[0]
            
            //点赞后的模型
            let newMessage = messageVM.message
            newMessage.likelist = likeNewStr["likelist"] as? String
            newMessage.likenum = likeNewStr["likenum"] as! Int
          
            messageVM.message = newMessage
            
            self.tableView.reloadData()
        }
        
    }
    //回复
    func replayBtnClicked(_ cell:HSMessageCell) {
        //记录当前cell，用于通知回调方法中计算cell的位置
        currentCell = cell
        if replayInputToolBar == nil || replayInputToolBar?.superview == nil {
            
            setupReplayInputToolBar()
            inputTextF?.becomeFirstResponder()
            
        }
    }
    
    //键盘监听通知的回调方法
    func keyboardNotification(notify:Notification) {
        //获得键盘的frame
        guard let keyboardFrame = notify.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        //根据键盘的位置确定工具条的位置
        let keyboardY = keyboardFrame.minY
        replayInputToolBar?.center = CGPoint(x: screenW/2, y: keyboardY - 22)
        
        //如果当前键盘隐藏，就移除工具条
        if keyboardY == screenH {
            replayInputToolBar?.removeFromSuperview()
        }
        
        //获得窗口视图
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        //获得cell对应窗口的frame
        let rect = keyWindow.convert(currentCell.frame, from: tableView)
        //获得当前cell的偏移量
        let offset = rect.maxY - keyboardY - 44
        
        if offset <= 0 {
            return
        }
        
        //当前表格视图的偏移量
        let currentOffsetY = tableView.contentOffset.y
        
        //重新设置表格视图的偏移位置
        let newOffsetP = CGPoint(x: 0, y: currentOffsetY + offset)
        
        //刷新表格视图的位置
        tableView.setContentOffset(newOffsetP, animated: true)
        
    }
    
    //回复按钮的监听回调方法
    func replaySureBtnClicked() {
        quitKeyboard()
        //获得当前cell对应的视图模型
        guard let messageVM = currentCell.messageVM else {
            return
        }
        
        //回复接口
        let replayURL = "ZH-schoolname-S-submitJXReplay"
        let replay_ID = messageVM.message.not_id
        guard let replayContent = inputTextF?.text,inputTextF?.text != "" else {
            HSAlertView.bottomAlertView("回复内容不能为空")
            return
        }
        //设置参数
        let parm:[String:Any] = ["key":userID,"id":replay_ID,"content":replayContent,"user_type":2]
        
        
        //上传数据到服务器
        HSAFNWorkTools.shared.request(url: replayURL, parameters: parm) { (data, err) in
            guard let data = data as? NSDictionary , let dictArr = data["data"] as? [[String:Any]] else {
                HSAlertView.bottomAlertView("回复数据加载异常")
                return
            }
            
            //创建一个回复模型的数组
            var replayModelArr = [HSReplayListModel]()
            for dict in dictArr {
                //初始化模型
                let model = HSReplayListModel(dict: dict)
                replayModelArr.append(model)
            }
            //获得当前消息模型
            let newMessageM = messageVM.message
            newMessageM.replaylist = replayModelArr
            
            //重新给模型赋值
            messageVM.message = newMessageM
            
            self.tableView.reloadData()
        }
    }
    
}
