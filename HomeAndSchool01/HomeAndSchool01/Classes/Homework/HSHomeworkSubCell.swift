//
//  HSHomeworkSubCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

class HSHomeworkSubCell: UITableViewCell {
    //题目序号
    @IBOutlet weak var subOrderLabel: UILabel!
    //题目内容
    @IBOutlet weak var subContentLabel: UILabel!
    //照片
    @IBOutlet weak var subImageV1: UIImageView!
    @IBOutlet weak var subImageV2: UIImageView!
    @IBOutlet weak var subImageV3: UIImageView!
    //文字内容距离底部的高度
    @IBOutlet weak var subHeightToBottom: NSLayoutConstraint!
    
    var subModel:HSHomeworkSubModel?{
        didSet {
            guard let submodel = subModel else {
                return
            }
            let subImages = [subImageV1,subImageV2,subImageV3]
            
            subOrderLabel.text = String(submodel.ht_order)
            if submodel.hc_photoPath != " " {
                subContentLabel.text = submodel.ht_title
                for image in subImages {
                    image?.isHidden = true
                }
            }else {
                subContentLabel.isHidden = true
                for image in subImages {
                    image?.image = UIImage(named: submodel.hc_photoPath!)
                }
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
