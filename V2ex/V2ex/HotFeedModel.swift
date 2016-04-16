//
//  HotFeedModel.swift
//  V2ex
//
//  Created by Lee on 16/4/16.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class HotFeedModel: NSObject {

    var member = MemberModel()
    var content:String = ""
    var replies = 0
    var id = 0
    var content_rendered:String = ""
    var  title:String = ""
    var  node = NodeModel()
    var  created = 0
    var  last_modified = 0
    var last_touched = 0
    var url:String = ""
    
//    func setupReplaceObjectClass() -> [String : String] {
//        return ["member": "MemberModel","node":"NodeModel"]
//    }
}
