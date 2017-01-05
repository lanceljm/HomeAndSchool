//
//  HSHomeworkCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSHomeworkCell: UITableViewCell {
    
    
    @IBOutlet weak var homeworkSubjectLabel: UILabel!
    
    @IBOutlet weak var homeworkTeacherLabel: UILabel!

    @IBOutlet weak var homeworkDateLabel: UILabel!
    
    @IBOutlet weak var homeworkStatusImageView: UIImageView!

    var homeworkVM : HSHomeworkModel? {
        didSet {
            homeworkSubjectLabel.text = homeworkVM?.courseName
            homeworkSubjectLabel.layer.cornerRadius = 10
            homeworkSubjectLabel.layer.masksToBounds = true
            homeworkSubjectLabel.layer.borderWidth = 1
            homeworkSubjectLabel.layer.borderColor = UIColor.colorWithHex(hexColor: 0x00a0e9).cgColor
            
            homeworkTeacherLabel.text = homeworkVM?.hw_tName
            homeworkDateLabel.text = homeworkVM?.hw_createDate
            
            guard let homeworkVM = homeworkVM  else {
                return
            }
            switch homeworkVM.subStatus {
            case 0:
                //已提交
//                homeworkStatusImageView.image = UIImage(named: "hw_base_commit")
                switch homeworkVM.checkStatus {
                case 0:
                    //已批改
                    homeworkStatusImageView.image = UIImage(named: "已批改")
                case 1:
                    //未批改
                    homeworkStatusImageView.image = UIImage(named: "未批改")
                default:
                    break
                }
            case 1:
                //未提交
                homeworkStatusImageView.image = UIImage(named: "hw_base_no_commit")
            default:
                break
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
