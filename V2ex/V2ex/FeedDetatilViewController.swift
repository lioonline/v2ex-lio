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

class FeedDetatilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var contentID = 0;
    private     var json:JSON = nil
    private    var  feedTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        feedTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped);
        self.view.addSubview(feedTableView);
        feedTableView.delegate = self;
        feedTableView.dataSource = self;
        
        feedTableView.backgroundColor = UIColor.redColor()
        
        feedTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "feed")
        print(contentID)
        self.getDateWithContetID(contentID)
    }
//    get date
    func getDateWithContetID(content:NSInteger)->() {
          let paramerers = ["id":contentID]
        Alamofire.request(.GET, V2_NEW, parameters:paramerers)
            .responseJSON { (request, response, result) -> Void in
                self.json = JSON(result.value!)
                print(self.json)
                
//                self.homeTableView.reloadData()
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
            return 20
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feed")
        return cell!;
        
    }
    

   
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
//        let btn = UIButton()
//        btn.center = self.view.center
//        btn.bounds = CGRectMake(0, 0, 60, 30)
//        btn.backgroundColor = UIColor.redColor()
//        self.view.addSubview(btn)
//        btn.addTarget(self, action: #selector(FeedDetatilViewController.dismiss), forControlEvents: UIControlEvents.TouchUpInside)
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
