//
//  FeedDetatilViewController.swift
//  V2ex
//
//  Created by Cocoa Lee on 9/29/15.
//  Copyright © 2015 lio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TTReflect


class FeedDetatilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate {
   
    var contentID = 0;
    private     var jsonDate:JSON = nil
    private     var replyDate:JSON = nil
    private     var feedReplyModelArray:NSMutableArray  = NSMutableArray()
    private     var  feedReplyCellHeight = NSMutableArray()
    private    var  feedTableView = UITableView()
    private     var  contenCellHeight:CGFloat = 0.0
    private var  htmlString = ""
    private var  contentModel = FeedContentModel()
    private  var contentHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "详情"
        
        feedTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped);
        self.view.addSubview(feedTableView);
        feedTableView.delegate = self;
        feedTableView.dataSource = self;
        
        
        feedTableView.registerClass(FeedContentCell.self, forCellReuseIdentifier: "feedContent")
        feedTableView.registerClass(FeedDetatilHeaderView.self, forHeaderFooterViewReuseIdentifier: "feedHeader")
        feedTableView.registerClass(FeedReplyCell.self, forCellReuseIdentifier: "feedreply")
        
        print("id==\(contentID)")
        self.getDateWithContetID(contentID)
        self.getReplyWithId(contentID)
        
        
    }
        //    get date
       func getDateWithContetID(content:NSInteger)->() {
          let paramerters = ["id":content]
         NetworkEngine.getDataFromServerWithURLStringAndParameter(V2_CONTENT,parameter: paramerters) { (restult) in
            
            print("content--\(restult)")
            self.contentModel = Reflect.model(json: restult[0], type: FeedContentModel.self)
            self.htmlString = "<html><head><style>img{height:auto;width:100%}</style></head><body >"+self.contentModel.content_rendered+"</body></html"

             self.contentModel.content_rendered = self.htmlString
            self.contenCellHeight = self.htmlString.sizeCalculationWithWidthAndHeightAndFont(Screen_W - 20, height: 10000, font: UIFont.systemFontOfSize(14)).height
            
            let mainQueue = dispatch_get_main_queue()
          dispatch_async(mainQueue, { 
                        self.feedTableView.reloadData()
          })
           
            
  
        }
        

    }
    
    func regularExpression(htmlString:NSString)-> (){
        let regular = ""
        let reg = NSRegularExpression(regularExpression(regular))
        let match = reg.matchesInString(regular, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, htmlString.length))
        
        if match.count != 0 {
            for mat in match {
                let rang = mat.range
                print("匹配结果\(rang.location,rang.length,htmlString.substringWithRange(rang))")
            }
        }
        
    }
    
//    get reply
    func getReplyWithId(contentID:NSInteger){
         let par = ["topic_id":contentID]
        NetworkEngine.getDataFromServerWithURLStringAndParameter(VC_CONTENT_REPLY,parameter: par) { (res) in
            print("res＋\(res)")
            
            
            for dic in res {
            
                let reply              = Reflect.model(json: dic, type: FeedReplyModel.self)
                self.feedReplyModelArray.addObject(reply)
                let contenString       = reply.content_rendered
                let htmlString         = "<html><head><style>img{height:auto;width:100%}</style></head><body >"+contenString+"</body></html"
                reply.content_rendered = htmlString

                let cellHeight:CGFloat = reply.content.sizeCalculationWithWidthAndHeightAndFont(Screen_W - 74, height: 10000, font: UIFont.systemFontOfSize(14)).height + 45;
                self.feedReplyCellHeight.addObject(cellHeight)
                
                
            }
            
            
            
            
            let mainQueue = dispatch_get_main_queue()
            dispatch_async(mainQueue, {
                self.feedTableView.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: UITableViewRowAnimation.None)
            })
            

        }
        
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.feedReplyModelArray.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell                    = tableView.dequeueReusableCellWithIdentifier("feedContent") as! FeedContentCell
            cell.content.attributedText = self.contentModel.content_rendered.utf8Data?.attributedString
            

//            cell.content.text = self.contentModel.content
//              cell.content.loadHTMLString(self.contentModel.content_rendered, baseURL: nil)
//            cell.content.delegate = self
//            cell.content.lee_text(self.contentModel.content)
//            cell.backgroundColor = UIColor.clearColor()
            print("contentSize:\(cell.content.contentSize)  =  \(cell.content.bounds.height)")
//            let size = cell.content.sizeThatFits(CGSizeMake(Screen_W, 100000))
//            cell.content.bounds = CGRectMake(0, 0, cell.content.bounds.width, size.height)
//            print("cellheight\(cell.bounds.height) ===  cellcontentviewheoght\(cell.contentView.bounds.height)")
            
            return cell;
        }
        
        else {
            let cell                     = tableView.dequeueReusableCellWithIdentifier("feedreply") as! FeedReplyCell
            let replyModel:FeedReplyModel = self.feedReplyModelArray[indexPath.row] as! FeedReplyModel
            let urlString                = V2_BASE + replyModel.member.avatar_normal
      
            cell.avatar.kf_setImageWithURL(NSURL(string:urlString)!, forState: UIControlState.Normal)
            cell.conten.lee_text(replyModel.content)

            cell.nameAndTime.text        = replyModel.member.username
            cell.conten.sizeToFit()

            return cell;
        }
      
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        }
        else {
            return 30
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            print("contenCellHeight\(contenCellHeight)")
            return contenCellHeight
        }
        else {
            return feedReplyCellHeight[indexPath.row] as! CGFloat
        }
    }
   
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerFirst  =  tableView.dequeueReusableHeaderFooterViewWithIdentifier("feedHeader") as! FeedDetatilHeaderView
            headerFirst.title.text = self.contentModel.title
            let urlString = V2_BASE + self.contentModel.member.avatar_normal
            headerFirst.avatar.kf_setImageWithURL(NSURL(string: urlString)!, forState: UIControlState.Normal)
            return headerFirst;
        }
        else{
            let reply = UILabel()
            reply.frame = CGRectMake(0, 0, Screen_W, 44)
            if self.feedReplyModelArray.count == 0 {
                reply.text = "  暂时没有回复"
            }
            else {
                reply.text = "  回复"

            }
            reply.font = UIFont.systemFontOfSize(12)
            return reply
        }
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if  indexPath.section == 0 {
            let content  = ContentViewController()
            content.content = self.htmlString
            self.navigationController?.pushViewController(content, animated: true)
        }
       
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    
    }
    
    
    func dismiss(){
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


