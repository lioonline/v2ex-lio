//
//  FeedReplyCell.swift
//  V2ex
//
//  Created by Lee on 16/4/12.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedReplyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    let avatar = UIButton()
    let name = UILabel()
    let time = UILabel()
    let conten = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func initView(){
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
