//
//  HSMessageController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSMessageController: UITableViewController {

    //使用列表模型加载数据
    let messagListModel = HSMessageListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注册
        tableView.register(UINib.init(nibName: "HSMessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")

        tableView.estimatedRowHeight = 350
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        //添加右上角
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "release_msg", taget: self, action: #selector(rightBtnClicked))
        
        //加载网络数据
        downLoadData()
    }
    
    func downLoadData() {
        messagListModel.loadDate {[weak self] (isRefresh) in
            if isRefresh {
                self?.tableView.reloadData()
            }
        }
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
        cell.message = messageM
        
        //处理相应cell对应的事件
        cell.likeBtnBlock = {(clickcell) in
            print("点赞",clickcell.message?.not_title ?? "")
        }
        cell.replyBtnBlock = {(clickcell) in
            print("回复",clickcell.message?.not_title ?? "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagListModel.messageModels.count
    }
}
