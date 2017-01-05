//
//  HSClassroomController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSClassroomController: UITableViewController {
    
    //使用列表模型加载数据
    let classroomViewModel = HSClassroomViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册
        tableView.register(UINib.init(nibName: "HSClassroomCell", bundle: nil), forCellReuseIdentifier: "classroomCell")

        tableView.rowHeight = 90
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        downLoad()
    }
    //加载网络数据
    func downLoad() {
        classroomViewModel.downLoadData { [weak self](isOK) in
            if isOK {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK:表格视图和数据源的代理
extension HSClassroomController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classroomViewModel.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classroomCell", for: indexPath) as! HSClassroomCell
        let classroomM = classroomViewModel.dataArr[indexPath.row]
        cell.classroomVM = classroomM
        return cell
    }
}
