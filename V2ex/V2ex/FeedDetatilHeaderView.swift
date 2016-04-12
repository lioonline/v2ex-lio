//
//  FeedDetatilHeaderView.swift
//  V2ex
//
//  Created by Lee on 16/4/12.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedDetatilHeaderView: UITableViewHeaderFooterView {

    let title = UITextView();
    let avatar = UIButton()
    
    
    override  init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "feedHeader")
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initView(){
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(title);
        title.frame = CGRectMake(0, 0, Screen_W-100, 80)
        title.text = "一个极简主义设计的 Hexo 主题 - Fexo v1.0"
        title.font = UIFont.systemFontOfSize(15)
        title.userInteractionEnabled = false

        self.contentView.addSubview(avatar)
        avatar.snp_makeConstraints { (make) in
//            make.left.equalTo(title.snp_right).offset(20)
            make.top.equalTo(title.snp_top).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-20)
            make.height.width.equalTo(40)
        }
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        avatar.setImage(UIImage(named:""), forState: UIControlState.Normal)
        avatar.backgroundColor = UIColor.redColor()
        
        
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        
        
        
    }
 

}
