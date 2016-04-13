//
//  NetworkEngine.swift
//  V2ex
//
//  Created by Lee on 16/4/13.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NetworkEngine: NSObject {

    class func getDataFromServerWithURLStringAndParameter(
        url:String,
        parameter:[String: AnyObject]? = nil,
        complete:NSArray->()
        )->(){
      
        
        Alamofire.request(.GET, url, parameters: parameter)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let JSON):
                    print("Success with JSON: \(JSON)")
                    let dic = JSON
                    print("dic :\(dic.self)")
                    complete(dic as! NSArray)
                    
                case .Failure(let data, let error):
                    print("Request failed with error: \(error)")
                    
                    if let data = data {
                        print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                    }
                }
        }
            
  }
}
