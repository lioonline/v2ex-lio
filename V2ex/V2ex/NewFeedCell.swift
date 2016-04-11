//
//  NewFeedCell.swift
//  V2ex
//
//  Created by Cocoa Lee on 9/29/15.
//  Copyright © 2015 lio. All rights reserved.
//

import UIKit
import SnapKit


class NewFeedCell: UITableViewCell {

    var vAvatar:UIImageView = UIImageView()
    var vName:UILabel  = UILabel()
    var vTime:UILabel  = UILabel()
    var vTitle:UILabel = UILabel()
    var vContent:UILabel = UILabel()
    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:"home")
        
        rendering()
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func rendering() -> Void{
       self.contentView.addSubview(vAvatar)
        vAvatar.layer.cornerRadius = 4
        vAvatar.clipsToBounds = true
        vAvatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.height.width.equalTo(30)
        }
        
        
//
        self.contentView.addSubview(vName)
        vName.text = "name(T)"
        vName.textColor = RGBA(140, g: 140, b: 140, a: 1)
        vName.font = UIFont.systemFontOfSize(12)
        vName.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(vAvatar.snp_right).offset(10)
            make.top.equalTo(vAvatar.snp_top)
        }
//
        self.contentView.addSubview(vTime)
        vTime.textColor = RGBA(175 , g: 175, b: 175, a: 1)
        vTime.text = "2015-09-23(T)"
        vTime.font = UIFont.systemFontOfSize(10)
        vTime .snp_updateConstraints { (make) -> Void in
            make.left.equalTo(vName.snp_left)
            make.top.equalTo(vName.snp_bottom).offset(5)
        }
//
//
        self.contentView.addSubview(vTitle)
        vTitle.text = "V2EX"
        vTitle.font = UIFont.systemFontOfSize(15)
        vTitle.textColor = RGBA(1, g: 117, b: 97, a: 1)
        vTitle.numberOfLines = 2
        vTitle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        vTitle.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(vTime.snp_left)
            make.top.equalTo(vAvatar.snp_bottom).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
        }
        

        
        
        
//        
//        self.contentView.addSubview(vContent)
//        vContent.font = UIFont.systemFontOfSize(12)
//        vContent.textColor = RGBA(110, g: 110, b: 110, a: 1)
//        vContent.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(vTitle.snp_left)
//            make.top.equalTo(vTitle.snp_bottom).offset(5)
//            make.right.equalTo(vTitle.snp_right)
//            make.bottom.equalTo(self.contentView.snp_bottom)
//        }
//        vContent.lineBreakMode =  NSLineBreakMode.ByTruncatingTail
//        vContent.numberOfLines = 0
        
        
        
      
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
