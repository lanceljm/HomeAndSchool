//
//  HSScheduleCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/28.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScheduleCell: UICollectionViewCell {
    
    //创建一个全局属性，用来接收保存科目名称
    let titleLabel = UILabel()
    
    //接收模型数据的属性
    var model:HSScheduleModel? {
        didSet {
            titleLabel.text = model?.courseName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加label
        titleLabel.frame = contentView.bounds
        
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.addSubview(titleLabel)
        
    }
    
    //取消阻止取值操作
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
