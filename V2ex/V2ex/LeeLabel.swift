//
//  LeeLabel.swift
//  V2ex
//
//  Created by Lee on 16/4/13.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class LeeLabel: NSString {

    class func transformString(originalStr:String)->NSString {
        
        let text:NSString = originalStr;
        _ = (text as String).utf8Data?.attributedString
        //解析http https
        let regexHTTP = "http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?"
        
        let regularHTTP = try! NSRegularExpression.init(pattern: regexHTTP, options: NSRegularExpressionOptions.CaseInsensitive)
        
          let httpArray = regularHTTP.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemHTTP in httpArray {
            let rang = itemHTTP.range
            let strhttp = text.substringWithRange(rang)
            print("http-----:\(strhttp)")
            
        }
        
        //解析@
        let regexAt = "@[\\u4e00-\\u9fa5\\w\\-]+"
        
        
        let regularAt = try! NSRegularExpression.init(pattern: regexAt, options: NSRegularExpressionOptions.CaseInsensitive)
        let atArray = regularAt.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemAt in atArray {
            let rang = itemAt.range
            let strhttp = text.substringWithRange(rang)
            print("at-----:\(strhttp)")
        }
        
        //解析话题
        let regexPound = "#([^\\#|.]+)#"
        let regularPound = try! NSRegularExpression.init(pattern: regexPound, options: NSRegularExpressionOptions.CaseInsensitive)
        let poundArray = regularPound.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemPound in poundArray {
            let rang = itemPound.range
            let itemPound = text.substringWithRange(rang)
            print("pound-----:\(itemPound)")
        }

        
        //解析& 无效
        
        let regexAnd = "\\$\\*?[\u{4e00}-\u{9fa5}|a-zA-Z|\\d]{2,8}(\\((SH|SZ)?\\d+\\))?"
        
        
        let regularAnd = try! NSRegularExpression.init(pattern: regexAnd, options: NSRegularExpressionOptions.CaseInsensitive)
        let andArray = regularAnd.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemAnd in andArray {
            let rang = itemAnd.range
            let strAnd = text.substringWithRange(rang)
            print("and-----:\(strAnd)")
        }
        
             // 解析表情  无效
        
        let regexEmoji = "\\[a−zA−Z0−9u4e00−u9fa5]+"
        let regularEmoji = try! NSRegularExpression.init(pattern: regexEmoji, options: NSRegularExpressionOptions.CaseInsensitive)
        let emojiArray = regularEmoji.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemEmoji in emojiArray {
            let rang = itemEmoji.range
            let itemPound = text.substringWithRange(rang)
            print("Emoji----:\(itemPound)")
        }
       //邮箱
        let regexEmail = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}"
        let regularEmail = try! NSRegularExpression.init(pattern: regexEmail, options: NSRegularExpressionOptions.CaseInsensitive)
        let EmailArray = regularEmail.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemEmail in EmailArray {
            let rang = itemEmail.range
            let itemEmail = text.substringWithRange(rang)
            print("Email----:\(itemEmail)")
        }

        //手机
        let regexPhone = "0?(13|14|15|18)[0-9]{9}"
        let regularPhone = try! NSRegularExpression.init(pattern: regexPhone, options: NSRegularExpressionOptions.CaseInsensitive)
        let phoneArray = regularPhone.matchesInString(text as String, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, text.length))
        
        for itemPhone in phoneArray {
            let rang = itemPhone.range
            let itemPhone = text.substringWithRange(rang)
            print("Phone----:\(itemPhone)")
        }
        
      
        
        
        return text
        
    }
    
}
