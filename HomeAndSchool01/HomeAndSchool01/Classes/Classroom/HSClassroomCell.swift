//
//  HSClassroomCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSClassroomCell: UITableViewCell {
    
    @IBOutlet weak var classrommIconView: UIImageView!
    
    @IBOutlet weak var classroomSubjectLabel: UILabel!
    
    @IBOutlet weak var classroomTeacherNameLabel: UILabel!

    @IBOutlet weak var classroomDateLabel: UILabel!
    
    var classroomVM :HSClassroomModel? {
        didSet {
            guard let classroomVM = classroomVM else {
                return
            }
            if classroomVM.usersex == "男" {
                classrommIconView.image = UIImage(named: "tboy")
            }else {
                classrommIconView.image = UIImage(named: "tgirl")
            }
            classrommIconView.layer.cornerRadius = 30
            classrommIconView.layer.masksToBounds = true
            
            classroomSubjectLabel.text = classroomVM.course
            classroomSubjectLabel.layer.cornerRadius = 10
            classroomSubjectLabel.layer.masksToBounds = true
            classroomSubjectLabel.layer.borderWidth = 1
            classroomSubjectLabel.layer.borderColor = UIColor.colorWithHex(hexColor: 0x00a0e9).cgColor
            
            classroomTeacherNameLabel.text = classroomVM.createName
            classroomDateLabel.text = classroomVM.creattime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
