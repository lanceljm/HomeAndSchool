//
//  HSScoreCell.swift
//  HomeAndSchool01
//
//  Created by ljm on 2016/12/31.
//  Copyright © 2016年 ljm. All rights reserved.
//

import UIKit

class HSScoreCell: UITableViewCell {

    @IBOutlet weak var scoreTitleLabel: UILabel!
    
    @IBOutlet weak var scoreSubjectLabel: UILabel!
    
    @IBOutlet weak var scoreTeacherNameLabel: UILabel!
    
    @IBOutlet weak var scoreDateLabel: UILabel!
    
//    @IBOutlet weak var scoreStatusImageView: UIImageView!
    @IBOutlet weak var scoreStatusBtnImage: UIButton!
    
    @IBOutlet weak var scoreReplayView: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreStatusLabel: UILabel!
    
    @IBOutlet weak var scoreTeacherJudgeLabel: UILabel!
 
    var scoreVM: HSScoreModel? {
        didSet {
             guard let scoreVM = scoreVM else {
                return
            }

            scoreTitleLabel.text = scoreVM.es_title

            scoreSubjectLabel.text = scoreVM.es_course
            scoreSubjectLabel.layer.cornerRadius = 10
            scoreSubjectLabel.layer.masksToBounds = true
            scoreSubjectLabel.layer.borderWidth = 1
            scoreSubjectLabel.layer.borderColor = UIColor.colorWithHex(hexColor: 0x00a0e9).cgColor
            
            scoreTeacherNameLabel.text = scoreVM.es_teacherName
            scoreDateLabel.text = scoreVM.es_createDate
            scoreLabel.text = String(scoreVM.es_score)

            scoreTeacherJudgeLabel.text = scoreVM.es_comment

            if scoreVM.es_score > 60 {
                //合格
                scoreStatusBtnImage.setBackgroundImage(UIImage(named:"scores_ok"), for: .normal)
                scoreStatusLabel.text = "合格"
            } else{
                //不合格
                scoreStatusBtnImage.setBackgroundImage(UIImage(named:"scores_ng"), for: .normal)
                scoreStatusLabel.text = "不合格"
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
