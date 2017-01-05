//
//  HSExaminationController.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/22.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSExaminationController: UITableViewController {

    //使用列表模型加载数组
    let scoreViewModel  = HSScoreViewModel()
    //cell的行数
    var cellRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册
        tableView.register(UINib.init(nibName: "HSScoreCell", bundle: nil), forCellReuseIdentifier: "scoreCell")
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none

        downLoad()
    }
    //加载网络数据
    func downLoad() {
        scoreViewModel.downLoadData { [weak self](isOK) in
            if isOK {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK:表格视图和数据源的代理
extension HSExaminationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreViewModel.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! HSScoreCell
        let scoreModel = scoreViewModel.dataArr[indexPath.row]
        cell.scoreVM = scoreModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HSScoreCell
        
        if cell.scoreReplayView.isHidden == true {
            cell.scoreReplayView.isHidden = false
            cellRow = indexPath.row
        }else {
            cell.scoreReplayView.isHidden = true
            cellRow -= 1
        }
        
        cell.selectionStyle = .none
        tableView.reloadData()
    }
    
    //调整行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cellRow {
            return 125
        }else {
            return 100
        }
    }
    
}
