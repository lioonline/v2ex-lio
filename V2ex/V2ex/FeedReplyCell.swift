//
//  FeedReplyCell.swift
//  V2ex
//
//  Created by Lee on 16/4/12.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedReplyCell: UITableViewCell,UITextViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    let avatar      = UIButton()
    let nameAndTime = UILabel()
    let conten      = LeeAttTextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func initView(){
        self.contentView.addSubview(avatar)
        avatar.layer.cornerRadius = 4
        avatar.clipsToBounds = true
//        self.avatar.backgroundColor = UIColor.redColor()
        self.avatar.layer.cornerRadius = 4
        self.avatar.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp_top).offset(10)
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.height.width.equalTo(44)
        }
        
        
        self.contentView.addSubview(nameAndTime)
       nameAndTime.textColor = RGBA(128, g: 128, b: 128, a: 1)
        nameAndTime.font =  UIFont.systemFontOfSize(12)
        self.nameAndTime.snp_makeConstraints { (make) in
            make.left.equalTo(self.avatar.snp_right).offset(10)
            make.top.equalTo(avatar.snp_top)
            make.height.equalTo(20)
            make.right.equalTo(self.contentView.snp_right).offset(-60)
        }
        
        
        self.contentView.addSubview(self.conten)
        conten.font = UIFont.systemFontOfSize(17)
        conten.scrollEnabled = false
        conten.editable = false
         conten.selectable = true
        conten.textContainer.lineFragmentPadding = 0
        conten.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        conten.delegate = self
        self.conten.snp_makeConstraints { (make) in
            make.top.equalTo(nameAndTime.snp_bottom).offset(5)
            make.left.equalTo(nameAndTime.snp_left)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        
        
        
    }
    
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool{
        
//        验证是邮箱 电话 还是URL
         NSLog("链接地址:\(URL.description)")
        
//        if URL.description.containsString("http"){
//            
//            return true
//        }
//        else {
            let alert = UIAlertView.init(title: URL.description, message: "", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
//            return false
         return false
//        }
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



