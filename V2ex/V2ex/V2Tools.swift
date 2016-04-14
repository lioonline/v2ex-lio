//
//  V2Tools.swift
//  V2ex
//
//  Created by Cocoa Lee on 9/29/15.
//  Copyright © 2015 lio. All rights reserved.
//

import UIKit

class V2Tools: NSObject {

   
    
}


func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:NSTimeInterval = string.doubleValue
    let dfmatter = NSDateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd:mm:ss"
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.stringFromDate(date))
    return dfmatter.stringFromDate(date)
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: Screen_W - 20 , height: 40)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    
    func heightWithConstrainedMax120Width(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: Screen_W - 20 , height: 120)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        print("height \(boundingBox.height)")
        
        return boundingBox.height + 5
    }
    
    func sizeCalculationWithWidthAndHeightAndFont(width:CGFloat,height:CGFloat,font:UIFont) -> CGRect{
        let rect = CGSizeMake(width, height);
        
        let boundingBox = self.boundingRectWithSize(rect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox
    }
    
    
  
    
    var utf8Data: NSData? {
        return dataUsingEncoding(NSUTF8StringEncoding)
    }
    var count: Int { return self.characters.count }

    
}
extension NSData {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}








