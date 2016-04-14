//
//  FeedContentCell.swift
//  V2ex
//
//  Created by Lee on 16/4/12.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedContentCell: UITableViewCell {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let content  = LeeAttTextView()
  
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        
     
        
        self.contentView.addSubview(content)
        content.font = UIFont.systemFontOfSize(17)
        content.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
        
        
        
        
//        content.lineBreakMode = NSLineBreakMode.ByTruncatingTail
////        content.numberOfLines = 0
        content.userInteractionEnabled  = false
//        content.font = UIFont.systemFontOfSize(14)
//
//        content.snp_makeConstraints { (make) in
//            make.left.equalTo(self.contentView.snp_left).offset(10)
//            make.right.equalTo(self.contentView.snp_right).offset(-10)
//            make.top.equalTo(self.contentView.snp_top).offset(10)
//            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//        }
    }

}
