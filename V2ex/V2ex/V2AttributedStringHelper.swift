//
//  V2AttributedStringHelper.swift
//  V2ex
//
//  Created by Lee on 16/4/15.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class V2AttributedStringHelper: NSObject {
    
    //解析
    class func transformString(originalStr:String)->(NSAttributedString) {
        
        let text:NSString = originalStr;
        let attStr = (text as String).utf8Data?.attributedString
        let attText = NSMutableAttributedString.init(attributedString: attStr!)
        //解析http https
        let regexHTTP = "http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?"
        
        let regularHTTP = try! NSRegularExpression.init(pattern: regexHTTP, options: NSRegularExpressionOptions.CaseInsensitive)
        let attTextString = attText.string
        let httpArray = regularHTTP.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemHTTP in httpArray {
            let rang = itemHTTP.range
            let strhttp = text.substringWithRange(rang)
            print("http-----:\(strhttp)------\(rang)")
            attText.addAttribute(NSLinkAttributeName, value: strhttp, range: rang)
            
            
        }
        
        
        //解析@
        let regexAt = "@[\\u4e00-\\u9fa5\\w\\-]+"
        
        
        let regularAt = try! NSRegularExpression.init(pattern: regexAt, options: NSRegularExpressionOptions.CaseInsensitive)
        let atArray = regularAt.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemAt in atArray {
            let rang = itemAt.range
            let strAt = text.substringWithRange(rang)
            
            attText.addAttribute(NSLinkAttributeName, value: strAt, range: rang)
            
            print("at-----:\(strAt)")
        }
        
        //解析话题
        let regexPound = "#([^\\#|.]+)#"
        let regularPound = try! NSRegularExpression.init(pattern: regexPound, options: NSRegularExpressionOptions.CaseInsensitive)
        let poundArray = regularPound.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemPound in poundArray {
            let rang = itemPound.range
            let itemPound = text.substringWithRange(rang)
            print("pound-----:\(itemPound)")
        }
        
        
        // 解析表情  无效
        
        let regexEmoji = "\\[a−zA−Z0−9u4e00−u9fa5]+"
        let regularEmoji = try! NSRegularExpression.init(pattern: regexEmoji, options: NSRegularExpressionOptions.CaseInsensitive)
        let emojiArray = regularEmoji.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemEmoji in emojiArray {
            let rang = itemEmoji.range
            let itemPound = text.substringWithRange(rang)
            print("Emoji----:\(itemPound)")
        }
        //邮箱
        let regexEmail = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}"
        let regularEmail = try! NSRegularExpression.init(pattern: regexEmail, options: NSRegularExpressionOptions.CaseInsensitive)
        let EmailArray = regularEmail.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemEmail in EmailArray {
            let rang = itemEmail.range
            let itemEmail = text.substringWithRange(rang)
            print("Email----:\(itemEmail)")
            attText.addAttribute(NSLinkAttributeName, value: itemEmail, range: rang)
            
        }
        
        //手机
        let regexPhone = "0?(13|14|15|18)[0-9]{9}"
        let regularPhone = try! NSRegularExpression.init(pattern: regexPhone, options: NSRegularExpressionOptions.CaseInsensitive)
        let phoneArray = regularPhone.matchesInString(attTextString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, attTextString.count))
        
        for itemPhone in phoneArray {
            let rang = itemPhone.range
            let itemPhone = text.substringWithRange(rang)
            print("Phone----:\(itemPhone)")
        }
        
        
        
        
        attText.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(0, attTextString.count))
        attText.addAttribute(NSForegroundColorAttributeName, value:  RGBA(119, g: 128, b: 135, a: 1), range: NSMakeRange(0, attTextString.count))
        
        let paragraph = NSMutableParagraphStyle()
        attText.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSMakeRange(0, attTextString.count))
        
        
        return attText
    }

}
