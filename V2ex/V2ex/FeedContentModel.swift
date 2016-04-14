//
//  FeedContentModel.swift
//  V2ex
//
//  Created by Lee on 16/4/13.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class FeedContentModel: NSObject {
 
    var content_rendered:String = ""
    var content:String          = ""
    var created                 = 0
    var  id                     = 0
    var last_modified           = 0
    var last_touched            = 0
    var member                  = MemberModel()
    var node                    = NodeModel()
    var replies                 = 0
    var title:String            = ""
    var url:String              = ""
    
    func setupReplaceObjectClass() -> [String : String] {
        return ["member": "MemberModel"]
    }

}
