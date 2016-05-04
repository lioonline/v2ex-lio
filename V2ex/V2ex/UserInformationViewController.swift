
//
//  UserInformationViewController.swift
//  V2ex
//
//  Created by Lee on 16/4/17.
//  Copyright © 2016年 lio. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var userName:String = ""
    var tableView:UITableView = UITableView()
    var userModel = UserModel()
    var headerImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "用户信息"
        
        print("username :\(userName)")
        self.initView()
        self.getUserInfoWithUserName(self.userName)
    }
    
    func initView(){
        
        tableView = UITableView.init(frame: CGRectMake(0, 0, Screen_W, Screen_H), style: UITableViewStyle.Grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "userInfoCell")
        tableView.registerClass(UserInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "userInfoHeader")
        
        
    }
    
    func getUserInfoWithUserName(userName:String){
        
        
        NetworkEngine.getDataFromServerWithURLString(V2_USERINFO + userName, complete: { (
            res) in
            let dic = res as! NSDictionary
            print( "用户信息:\(dic)")
            
            self.userModel = UserModel.yy_modelWithJSON(dic)!
            print("name:\(self.userModel.username)")
            
            self.tableView.reloadData()
            
            }) { (error) in
                
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userInfoCell")
        
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("userInfoHeader") as! UserInfoHeaderView
        header.bgImageView.kf_setImageWithURL(NSURL.init(string:V2_BASE + self.userModel.avatar_large)!,placeholderImage: self.headerImage);
        header.avatarImageView.kf_setImageWithURL(NSURL.init(string:V2_BASE + self.userModel.avatar_large)!, placeholderImage: self.headerImage);
        header.userNameLabel.text = self.userModel.username
        if self.userModel.bio.count > 0 {
            header.signatureLabel.text = self.userModel.bio
        }
        else{
            header.signatureLabel.text = "没有签名"

        }
        return header
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
