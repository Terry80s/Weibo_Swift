//
//  MainTabBarController.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/08.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1.初始化加号按钮
        setupComposeButton()
    }
    
    // MARK: - 内部控制方法
    // 如果在方法前面加上private, 代表这个方法只能在当前文件中访问
    // 如果在属性前面加上private, 代表这个属性只能在当前文件中访问
    // 如果在类前面加上private,  代表这个类只能在当前文件中访问
    /// 添加加号按钮
    private func setupComposeButton()
    {
        // 0.将加号按钮添加到tabbar上
        tabBar.addSubview(composeButton)
        
        // 1.计算宽度
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)-1
        // 2.计算高度
        let height = 0
        // 3.修改frame
        //bounds(界限) 声明该视图的定位和大小
        //insetBy（返回一个中间位置的矩形，比原来的大或者小）
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*width, dy: CGFloat(height))
    }
    
    
    // MARK: - 懒加载
    private lazy var composeButton: UIButton = {
        let btn=UIButton(imageName:"tabbar_compose_button",backImageName:"tabbar_compose_icon_add")
        btn.addTarget(self, action: #selector(composeBtnClick), for: UIControlEvents.touchUpInside)
        return btn;
    }()
    // FIXME: 写微博没有实现
    @objc func composeBtnClick() {
        print("写微博")
    }
    
    /**
     加载所有的子视图控制器
     */
    private func addChildViewControllers() {
        self.tabBar.tintColor = UIColor.orange
        
        addChildViewController(storyboardName: "HomePage", title: "首页", iconName: "tabbar_home")
        addChildViewController(storyboardName: "Message", title: "消息", iconName: "tabbar_message_center")
        // 发微博，占空位
        addChildViewController(UIViewController())
        addChildViewController(storyboardName: "Discover", title: "发现", iconName: "tabbar_discover")
        addChildViewController(storyboardName: "Profile", title: "我", iconName: "tabbar_profile")
        
    }
    
    /**
     加载子视图控制器
     :param: storyboardName storyboard名称
     :param: title          标题
     :param: iconName       图标名称
     */
    private func addChildViewController(storyboardName: String, title: String, iconName: String) {
        /**
         *  从storyboard中取出初始化控制器
         */
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let nav = sb.instantiateInitialViewController() as! UINavigationController
        /**
         *  设置该控制器在TabBar上显示的相关属性
         */
        nav.title = title
        nav.tabBarItem.image = UIImage(named: iconName)
        nav.tabBarItem.selectedImage = UIImage(named: iconName + "_highlighted")
        /**
         *  将设置完毕的控制器作为子控制器添加到TabBarController中
         */
        addChildViewController(nav)
    }
}
