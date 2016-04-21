//
//  FeeReplyModel.swift
//  V2ex
//
//  Created by Lee on 16/4/13.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedReplyModel: NSObject {

    var content:String          = ""
    var content_rendered:String = ""
    var  created                = 0
    var  id                     = 0
    var  last_modified          = 0
    var   thanks                = 0
    var  member                 = MemberModel()
    
    
    var   contentAttString:NSAttributedString = NSAttributedString()


    
    
}
