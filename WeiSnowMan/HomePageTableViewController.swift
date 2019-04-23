//
//  HomePageTableViewController.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/08.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import SDWebImage

private let originalCellID = "originalCellID"
private let retweededCellID = "retweededCellID"

class HomePageTableViewController : BViewController{
    
    //懒加载一个假数据
    fileprivate lazy var listViewModel = XQWBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        self.refreshControl = UIRefreshControl()
        refreshControl = UIRefreshControl();
        refreshControl?.attributedTitle = NSAttributedString(string:"Hello，下拉更新啊！")
        tableView?.addSubview(refreshControl!);
        
        tableView.estimatedRowHeight = 40
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // 重写 setupUI()
    override func setupUI() {
        self.title = "首页"
        
    }
    
    @IBAction func onLoginBtn(_ sender: UIButton) {
        
        let redirectURIx = "https://api.weibo.com/oauth2/default.html"
        let request: WBAuthorizeRequest! = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = redirectURIx
        request.scope = "all"
        
        WeiboSDK.send(request)
        
    }
    
    override func loadData() { // 异步延时加载数据
        
        listViewModel.loadStatus(pullup: self.isPullup) { (isSuccess, shouldRefresh) in
            self.isPullup = false
            self.refreshControl?.endRefreshing()
            self.tableView?.reloadData()
            if  shouldRefresh {
                self.tableView?.reloadData()
            }
        }
        
        
    }
    //指定加载行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomCell {
        let viewModel = listViewModel.statusList[indexPath.row]
        //let cellID = (viewModel.retweeted_status != nil) ? retweededCellID : originalCellID
        // 1.取出cell
        //        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! XQWBStatusCell
        //        // 2.设置cell
        //        cell.delegate = self as! XQWBStatusCellDelegate
        //        cell.viewModel = viewModel
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.statusLabel.font = UIFont.systemFont(ofSize: 13)
        cell.statusLabel.adjustsFontSizeToFitWidth=true
        var statusLabelVal = viewModel.text
        if (viewModel.retweeted_status?.text != nil){
            cell.statusLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            //cell.statusLabel.numberOfLines = 0
            let retweetedVal = viewModel.retweeted_status?.text
            
          statusLabelVal = statusLabelVal! + "\n" + (retweetedVal)!
        }
        
        cell.statusLabel.text = statusLabelVal
        
        cell.nameLabel.text = viewModel.user?.screen_name
        
        cell.createDate.text = Utility.updateTimeToCurrennTime(timeStampStr: viewModel.created_at!)
        
        let url = NSURL(string: (viewModel.user?.profile_image_url)!)!
        
        //cell.iconView.clipsToBounds = Bool(YES);
        
        cell.iconView.layer.cornerRadius = 3;
        
        cell.iconView.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "default_logo"),
                                  options: .transformAnimatedImage, progress: nil, completed: nil)
        
        if (viewModel.retweeted_status?.pic_urls != nil){
            cell.reloadData(images: (viewModel.retweeted_status?.pic_urls!)!)
        }else if (viewModel.pic_urls != nil){
            cell.reloadData(images: viewModel.pic_urls!)
        }else{
            cell.collectionView = nil
        }
        
        //cell.statusLabel?.setNeedsLayout()
        // 3.返回cell
        return cell
    }
    
    
    
    
    
    
}
