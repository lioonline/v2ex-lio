//
//  FeedContentCell.swift
//  V2ex
//
//  Created by Lee on 16/4/12.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedContentCell: UITableViewCell,UITextViewDelegate {

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
//        content.backgroundColor = UIColor.redColor()
        content.font = UIFont.systemFontOfSize(17)
        content.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        content.userInteractionEnabled = false
//        content.editable = false
        content.selectable = true
//        content.delegate = self
//        

    }
    
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        NSLog("链接地址:\(URL.description)")
        return true
    }
    

}
