//
//  HomeTableViewController.swift
//  V2ex
//
//  Created by Lee on 16/4/11.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeTableViewController: UITableViewController,UIViewControllerTransitioningDelegate {
    
    private   let moreButton  = UIButton()
    private     var json:JSON = nil


    private struct Constants {
        static let RowsCount = 20
        static let CellColors: [UIColor] = [
            .greenColor(),
            .blueColor(),
            .orangeColor(),
            .cyanColor(),
            .redColor(),
            .purpleColor(),
            .magentaColor(),
            .brownColor()
        ]
        static let DemoAnimationDuration = 5.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false

       self.tableView.registerClass(NewFeedCell.self, forCellReuseIdentifier: "cell")
        self.title = "V2EX"
        
//        add button 
        let window = UIApplication.sharedApplication().keyWindow

        window!.addSubview(moreButton)
        moreButton.backgroundColor = UIColor.blueColor()
       
        moreButton.layer.cornerRadius = 30;
        moreButton.clipsToBounds = true
        moreButton.frame = CGRectMake(30, Screen_H - 90 , 60, 60)
        
        self.getNewFeed()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewFeedCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewFeedCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let urlString = V2_BASE + json[indexPath.row]["member"]["avatar_normal"].string!
        cell.vAvatar.kf_setImageWithURL(NSURL(string:urlString)!)
//        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.vName.text = json[indexPath.row]["member"]["username"].string
        cell.vTitle.text = json[indexPath.row]["title"].string
        cell.vContent.text = json[indexPath.row]["content"].string!
//
        let timestring = json[indexPath.section]["created"].intValue
        let t = timeStampToString("\(timestring)")
        cell.vTime.text  = t
//        print("time \(timestring)")

        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let feedDetatil = FeedDetatilViewController()
        self.moreButtonDismissAnimation()
        
        self.navigationController?.pushViewController(feedDetatil, animated: true)
    }
    
    // MARK: - Navigation
    
    private let animationController = DAExpandAnimation()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController
        
        if let selectedCell = sender as? UITableViewCell {
            toViewController.transitioningDelegate = self
            toViewController.modalPresentationStyle = .Custom
            toViewController.view.backgroundColor = selectedCell.backgroundColor
            
            animationController.collapsedViewFrame = {
                return selectedCell.frame
            }
            animationController.animationDuration = Constants.DemoAnimationDuration
            
            if let indexPath = tableView.indexPathForCell(selectedCell) {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }
//    MARK -scrollView
    
  private  var lastContentOffset:CGFloat = 0.0;
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y;
    }
    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (lastContentOffset < scrollView.contentOffset.y) {
            NSLog("向上滚动");
            self.moreButtonDismissAnimation()
        }else{
            NSLog("向下滚动");
            self.moreButtonAppearAnimation()
        }
    }
// button anamation
    
    
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
        
        Alamofire.request(.GET, V2_NEW, parameters:nil)
            .responseJSON { (request, response, result) -> Void in
                self.json = JSON(result.value!)
                print(self.json)
                
                self.tableView.reloadData()
        }
        
    }
    
}
