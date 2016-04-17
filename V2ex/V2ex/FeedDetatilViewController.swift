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
import Kingfisher


class FeedDetatilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate {

    var contentID                                      = 0;
    private     var jsonDate:JSON                      = nil
    private     var replyDate:JSON                     = nil
    private     var feedReplyModelArray:NSMutableArray = NSMutableArray()
    private     var  feedReplyCellHeight               = NSMutableArray()
    private     var  feedTableView                     = UITableView()
    private     var  contenCellHeight:CGFloat          = 0.0
    private     var  htmlString                        = ""
    private     var  contentModel                      = FeedContentModel()
    private     var contentHeight:CGFloat              = 0.0
    private     var htmlTest:NSMutableAttributedString = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "详情"
        
        feedTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped);
        self.view.addSubview(feedTableView);
        feedTableView.delegate   = self;
        feedTableView.dataSource = self;
        
        
        feedTableView.registerClass(FeedContentCell.self, forCellReuseIdentifier: "feedContent")
        feedTableView.registerClass(FeedDetatilHeaderView.self, forHeaderFooterViewReuseIdentifier: "feedHeader")
        feedTableView.registerClass(FeedReplyCell.self, forCellReuseIdentifier: "feedreply")
        
        self.getDateWithContetID(contentID)
        self.getReplyWithId(contentID)
        
        
    }
        //    get date
       func getDateWithContetID(content:NSInteger)->() {
        let paramerters = ["id":content]
        
        NetworkEngine.getDataFromServerWithURLStringAndParameter(V2_CONTENT,parameter: paramerters, complete: { (restult) in
            self.contentModel     = FeedContentModel.yy_modelWithJSON(restult[0])!//Reflect.model(json: restult[0], type: FeedContentModel.self)
            self.htmlString       = "<html><head><style>img{height:auto;width:100%}</style></head><body >"+self.contentModel.content_rendered+"</body></html"
            self.contenCellHeight = self.htmlString.sizeCalculationWithWidthAndHeightAndFont(Screen_W - 20, height: 10000, font: UIFont.systemFontOfSize(14)).height + 20
            
            
            self.contentModel.content_rendered = self.htmlString
            let mainQueue = dispatch_get_main_queue()
            dispatch_async(mainQueue, {
                self.feedTableView.reloadData()
            })
            
            }) { (error) in
                print("error:\(error)")
        }
        
    }
    
    
    //    get reply
    func getReplyWithId(contentID:NSInteger){
         let par = ["topic_id":contentID]
        
        
        NetworkEngine.getDataFromServerWithURLStringAndParameter(VC_CONTENT_REPLY,parameter: par, complete: { (res) in
            
            for dic in res {
                
                let reply              = FeedReplyModel.yy_modelWithJSON(dic)!//Reflect.model(json: dic, type: FeedReplyModel.self)
                let contenString       = reply.content_rendered
                let htmlString         = "<html><head><style>img {max-width: 100%; height: auto;}</style></head><body >"+contenString+"</body></html"
                reply.content_rendered = htmlString
                reply.contentAttString = V2AttributedStringHelper.transformString(reply.content)
                self.feedReplyModelArray.addObject(reply)
                let cellHeight:CGFloat = reply.content.sizeCalculationWithWidthAndHeightAndFont(Screen_W - 74, height: 10000, font: UIFont.systemFontOfSize(14)).height + 50;
                self.feedReplyCellHeight.addObject(cellHeight)
            }
            let mainQueue = dispatch_get_main_queue()
            dispatch_async(mainQueue, {
                self.feedTableView.reloadData()
            })
            
            
            }) { (error) in
                print("error\(error)")
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
            let att  =  self.contentModel.content_rendered.utf8Data?.attributedString
            let attmut  = NSMutableAttributedString.init(attributedString: att!)
            attmut.addAttribute(NSForegroundColorAttributeName, value:  RGBA(119, g: 128, b: 135, a: 1), range: NSMakeRange(0, attmut.string.count))
            attmut.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(0, attmut.string.count))
            cell.content.attributedText = attmut
            cell.content.sizeToFit()
            return cell;
        }
        
        else {
            let cell                     = tableView.dequeueReusableCellWithIdentifier("feedreply") as! FeedReplyCell
            let replyModel:FeedReplyModel = self.feedReplyModelArray[indexPath.row] as! FeedReplyModel
            let urlString                = V2_BASE + replyModel.member.avatar_normal
            cell.avatar.kf_setImageWithURL(NSURL(string:urlString)!, forState: UIControlState.Normal)
            cell.avatar.tag = indexPath.row
            cell.avatar.addTarget(self, action: #selector(FeedDetatilViewController.pushToUserInformationViewControlerWith(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//            直接赋值
            cell.conten.attributedText   = replyModel.contentAttString
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
            let reply   = UILabel()
            reply.frame = CGRectMake(0, 0, Screen_W, 44)
            if self.feedReplyModelArray.count == 0 {
            reply.text  = "  "
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
    
    
    func pushToUserInformationViewControlerWith(btn:UIButton)->(){
        
        let model:FeedReplyModel = self.feedReplyModelArray[btn.tag] as! FeedReplyModel
        
        let username = model.member.username
        
        let userInfo = UserInformationViewController()
        userInfo.userName = username
        self.navigationController?.pushViewController(userInfo, animated: true)
        
        print("tag \(btn.tag)")
        
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


