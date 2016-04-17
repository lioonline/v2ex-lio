//
//  BaseModel.swift
//  V2ex
//
//  Created by Lee on 16/4/17.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    
    class func getDateFromeServerWithURLAndParParameter(
        urlString:String,
        par:[String: AnyObject]? = nil,
        complete:NSArray->()
        )->(){
        NetworkEngine.getDataFromServerWithURLStringAndParameter(urlString,parameter: par, complete: { (res) in
            
            }) { (error) in
                
        }
        
        
    }
    
    
    
    
    
    
}
