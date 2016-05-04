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
import TTReflect



class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private   let moreButton  = UIButton()
    private  var homeTableView = UITableView()
    private var  hotModelArray:NSMutableArray = []
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
        moreButton.addTarget(self, action: #selector(HomeViewController.pushToNodeViewControler), forControlEvents: UIControlEvents.TouchUpInside)
        self.title = "V2EX 最热"
        

    }
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotModelArray.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewFeedCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewFeedCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let hotModel:HotFeedModel = self.hotModelArray[indexPath.row] as! HotFeedModel
        cell.vAvatar.kf_setImageWithURL(NSURL.init(string:V2_BASE + hotModel.member.avatar_normal)!, forState:UIControlState.Normal )
        cell.vAvatar.tag = indexPath.row
        cell.vAvatar.addTarget(self, action:#selector(HomeViewController.pushToUserInformationViewControlerWith(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.vName.text = hotModel.member.username
        cell.vTitle.text = hotModel.title
        cell.vContent.text = hotModel.content
        let timestring = hotModel.created
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
        let model:HotFeedModel = self.hotModelArray[indexPath.row] as! HotFeedModel
        feedDetatil.contentID =  model.id
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
        
        
        NetworkEngine.getDataFromServerWithURLStringAndParameter(V2_HOT, parameter: nil,complete: { (res) in
            for dic in res {
                
                let hotFeedModel = HotFeedModel.yy_modelWithJSON(dic)
                print("username==>\(hotFeedModel?.member.username)")
                self.hotModelArray.addObject(hotFeedModel!)
                
            }
            self.homeTableView.reloadData()
            
            }) { (error) in
                print("error\(error)")
        }

    }
    
    /**
     跳转用户信息页面
     
     - parameter btn: btn
     */
    func pushToUserInformationViewControlerWith(btn:UIButton)->(){
       
        let cell:NewFeedCell = self.homeTableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: btn.tag, inSection: 0)) as! NewFeedCell;
        let model:HotFeedModel = self.hotModelArray[btn.tag] as! HotFeedModel
    
        let username = model.member.username
        
        let userInfo = UserInformationViewController()
        userInfo.userName = username
        userInfo.headerImage = (cell.vAvatar.imageView?.image)!
        self.navigationController?.pushViewController(userInfo, animated: true)
        
        print("tag \(btn.tag)")

    }
    
    /**
     跳转到节点页面
     */
    func pushToNodeViewControler(){
        let node = NodeViewController()
        self.navigationController?.pushViewController(node, animated: true)
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
