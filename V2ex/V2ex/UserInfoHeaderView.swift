//
//  UserInfoHeaderView.swift
//  V2ex
//
//  Created by Lee on 16/4/21.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class UserInfoHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bgImageView = UIImageView()
    let avatarImageView = UIImageView()
    let userNameLabel = UILabel()
    let signatureLabel = UILabel()
    
    func initView(){
        self.contentView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.contentView).offset(0)
        }
        bgImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let visuaEfView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        bgImageView.addSubview(visuaEfView)
        visuaEfView.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.contentView).offset(0)
        }
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(avatarImageView)
        avatarImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp_centerX);
            make.top.equalTo(self.contentView.snp_top).offset(10);
            make.width.height.equalTo(60);
        }
        avatarImageView.layer.cornerRadius = 30;
        avatarImageView.clipsToBounds = true
        
       self.contentView.addSubview(userNameLabel)
        userNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.top.equalTo(avatarImageView.snp_bottom).offset(10)
            make.height.equalTo(20)
        }
        userNameLabel.font = UIFont.systemFontOfSize(14)
        userNameLabel.textColor = UIColor.whiteColor()
       
        self.contentView.addSubview(signatureLabel)
        signatureLabel.snp_makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp_bottom).offset(5)
            make.height.equalTo(40)
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-10)

        }
//        signatureLabel.backgroundColor = UIColor.redColor()
        signatureLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        signatureLabel.numberOfLines = 0
        signatureLabel.font = UIFont.systemFontOfSize(12)
        signatureLabel.textColor = UIColor.whiteColor()
        signatureLabel.textAlignment = NSTextAlignment.Center
        
    
    }
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
