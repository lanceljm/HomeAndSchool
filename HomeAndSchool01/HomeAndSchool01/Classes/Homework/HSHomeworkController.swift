//
//  HSHomeworkController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSHomeworkController: UITableViewController {
    
    //使用列表模型加载数据
    let homeworkM = HSHomeWorkViewModel()

     override func viewDidLoad() {
        super.viewDidLoad()

        //注册
        tableView.register(UINib.init(nibName: "HSHomeworkCell", bundle: nil), forCellReuseIdentifier: "homeworkCell")
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        downLoadData()
    }
    //加载网络数据
    func downLoadData() {
        homeworkM.loadData { [weak self](isOK) in
            if isOK {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK:表格视图和数据源的代理
extension HSHomeworkController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkM.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell", for: indexPath) as! HSHomeworkCell
        
        let homeworkModel = homeworkM.dataArr[indexPath.row]
        cell.homeworkVM = homeworkModel
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HSHomeDetailController")
        present(detailVC, animated: true, completion: nil)
    }
}
