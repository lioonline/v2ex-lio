//
//  HomeViewController.swift
//  V2ex
//
//  Created by Lee on 16/4/11.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private   let moreButton  = UIButton()
    private     var json:JSON = nil
    private  var homeTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNewFeed()
        self.initView()
    }
    
    func initView(){
        self.view.backgroundColor = UIColor.whiteColor()
        
        homeTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain);
        self.view.addSubview(homeTableView)
        homeTableView.registerClass(NewFeedCell.self, forCellReuseIdentifier: "cell")
        homeTableView.delegate = self;
        homeTableView.dataSource = self;
        
        self.view.addSubview(moreButton)
        moreButton.backgroundColor = UIColor.blueColor()
        moreButton.layer.cornerRadius = 30;
        moreButton.clipsToBounds = true
        moreButton.frame = CGRectMake(30, Screen_H - 90 , 60, 60)
        
        self.title = "V2EX 最热"
        

    }
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewFeedCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewFeedCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let urlString = V2_BASE + json[indexPath.row]["member"]["avatar_normal"].string!
        cell.vAvatar.kf_setImageWithURL(NSURL(string:urlString)!)
        cell.vName.text = json[indexPath.row]["member"]["username"].string
        cell.vTitle.text = json[indexPath.row]["title"].string
        cell.vContent.text = json[indexPath.row]["content"].string!
        let timestring = json[indexPath.row]["created"].intValue
        let t = timeStampToString("\(timestring)")
        cell.vTime.text  = t
        
        return cell
    }

     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let feedDetatil = FeedDetatilViewController()
        self.moreButtonDismissAnimation()
        feedDetatil.contentID = json[indexPath.row]["id"].intValue
        self.navigationController?.pushViewController(feedDetatil, animated: true)
    }
    
    
    //    MARK -scrollView
    
    private  var lastContentOffset:CGFloat = 0.0;
    
     func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y;
    }
    
     func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (lastContentOffset < scrollView.contentOffset.y) {
            NSLog("向上滚动");
            self.moreButtonDismissAnimation()
        }else{
            NSLog("向下滚动");
            self.moreButtonAppearAnimation()
        }
    }

    
    
    func  moreButtonDismissAnimation() {
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.moreButton.frame = CGRectMake(30 , Screen_H+30,60, 60)
        }) { (Bool) in
        }
    }
    //
    func moreButtonAppearAnimation() {
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.moreButton.frame = CGRectMake(30 , Screen_H-90,60, 60)
        }) { (Bool) in
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.moreButtonAppearAnimation()
    }
    
    //    请求最新数据
    func getNewFeed() ->Void{
        
        Alamofire.request(.GET, V2_HOT, parameters:nil)
            .responseJSON { (request, response, result) -> Void in
                self.json = JSON(result.value!)
                print(self.json)
                
                
                self.homeTableView.reloadData()
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
