//
//  BaseViewController.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/10.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//
import UIKit


class BViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // 自定义导航条
    //lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
    lazy var navigationBar = UINavigationBar()
    
    
    // 自定义导航项  以后设置导航栏内容 用navItem
    lazy var navItem  = UINavigationItem()
    
    // 表格视图 - 如果没有登录,就不创建
    //tableView:UITableView?
    
    
    /// 刷新控件
    //var refreshControl: UIRefreshControl?
    /// 区分上拉刷新标记
    var isPullup = false

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1.判断是不是最后一行
        let row = indexPath.row
        // 行
        let section = tableView.numberOfSections - 1
        // 最后一组
        if row < 0 || section < 0 { return }
        let count = tableView.numberOfRows(inSection: section)
        // 最后一点组的的行数
        if row == (count - 1) && !isPullup { isPullup = true; loadData()
        }
    }
    func loadData(){
    
    }

    
    // 设置表格视图
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        //view.insertSubview(tableView!, belowSubview: navigationBar)
        // 设置数据源和代理
        tableView?.delegate = self
        tableView?.dataSource = self
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
    }
    
    //添加 setupUI() 方法,设置基本UI,可以让子类重写
    func setupUI() {
        // 随机背景颜色
        //view.backgroundColor = UIColor.random()
        // 添加导航条
        view.addSubview(navigationBar)
        // 设置item
        navigationBar.items = [navItem]
        // 设置navbar 的渲染颜色
        navigationBar.barTintColor = UIColor.init(withHex: "0xF6F6F6")
        // 设置navbar title 字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        
    }
    //重写 title 的disSet 方法,设置navItem.title
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
}
