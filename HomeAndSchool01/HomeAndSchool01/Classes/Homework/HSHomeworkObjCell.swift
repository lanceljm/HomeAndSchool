//
//  HSHomeworkObjCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2017/1/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

class HSHomeworkObjCell: UITableViewCell {

    //序号
    @IBOutlet weak var objOrderLabel: UILabel!
    //标题
    @IBOutlet weak var objTitleLabel: UILabel!
    //题目类型
    @IBOutlet weak var objQuestionType: UIImageView!
    
    @IBOutlet weak var objSelectorBtnA: UIButton!
    
    @IBOutlet weak var objSelectorBtnB: UIButton!
    
    @IBOutlet weak var objSelectorBtnC: UIButton!
    
    @IBOutlet weak var objSelectorBtnD: UIButton!
    
    @IBOutlet weak var objLabelA: UILabel!
    @IBOutlet weak var objLabelB: UILabel!
    @IBOutlet weak var objLabelC: UILabel!
    @IBOutlet weak var objLabelD: UILabel!
    
    var objModel:HSHomeworkObjModel?{
        didSet {
            guard let objModel = objModel else {
                return
            }
            objOrderLabel.text = String(objModel.ht_order)
            objTitleLabel.text = objModel.ht_title
            
            var newText = ""
            for (index,values) in (objModel.ht_option?.enumerated())! {
                newText = values["ho_text"] as! String
                switch index {
                case 0:
                    //选项A
                    objLabelA.text = newText
                case 1:
                    //选项B
                    objLabelB.text = newText
                case 2:
                    //选项C
                    objLabelC.text = newText
                default:
                    //选项D
                    objLabelD.text = newText
                    break
                }
            }
            
            let objSelectorArr = [objSelectorBtnA,objSelectorBtnB,objSelectorBtnC,objSelectorBtnD]
            let questionType = objModel.ht_type
            switch questionType {
            case 1:
                //单选
                for btn in objSelectorArr {
                    btn?.layer.cornerRadius = 5
                    btn?.layer.masksToBounds = true
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.black.cgColor
                    btn?.tag = objSelectorArr.startIndex
                }
                

            case 2:
                //多选
                for btn in objSelectorArr {
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.black.cgColor
                }
            case 3:
                //对错
                for btn in objSelectorArr {
                    btn?.layer.cornerRadius = 5
                    btn?.layer.masksToBounds = true
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.black.cgColor
                }
            case 4:
                //主观题
                print("主观题")
            default:
                break
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
