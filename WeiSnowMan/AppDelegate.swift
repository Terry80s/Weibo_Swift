//
//  AppDelegate.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/08.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit

/*
 1. command + shift + j ->快速定位到层级结构
 2.按下回车 -->改文件夹的名称
 3.command + c -->拷贝文件名称
 4.command + n -->新建文件
 5.command + v -->粘贴文件名称
 6.回车
 7.重复以上操作
 */

// T的含义: 外界传入什么就是什么
func JPLog<T>(message: T, file: NSString = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {
    
    var window: UIWindow?
    
    let appKey = "695652012"
    let appSecret = "27a6ba4e6e0e651f167bedfa2469d8be"
    //let redirectURI = "https://api.weibo.com/oauth2/default.html"
    var accessToken:String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(appKey)
        
        // 1.创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // 2.创建根控制器
        window?.rootViewController = MainTabBarController()
        // 3.显示界面
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func application(_ application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return WeiboSDK.handleOpen(url as URL!, delegate: self)
    }
    
    
    /**
     收到一个来自微博客户端程序的响应
     收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
     @param response 具体的响应对象
     /* 回调时候 代码说明
     */
     */
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if (response is (WBSendMessageToWeiboResponse)) {
            let message = "响应状态:\(response.statusCode.rawValue)\n响应UserInfo数据:\(response.userInfo)\n原请求UserInfo数据:\(response.requestUserInfo)"
            let alert = UIAlertView(title: "发送结果", message: message, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        } else if (response is (WBAuthorizeResponse)) {
            //let message = "响应状态: \(response.statusCode.rawValue)\nresponse.userId: \((response as! WBAuthorizeResponse).userID)\nresponse.accessToken: \((response as! WBAuthorizeResponse).accessToken)\n响应UserInfo数据: \(response.userInfo)\n原请求UserInfo数据: \(response.requestUserInfo)"
            //let alert = UIAlertView(title: "认证结果", message: message, delegate: nil, cancelButtonTitle: "确定")
            //alert.show()
            
            if (response.statusCode.rawValue == 0){
                accessToken = (response as! WBAuthorizeResponse).accessToken
                print("认证成功"+accessToken)
                
            }else{
                print("认证失败")
            }
            
            
            
        }
    }
    
    /**
     收到一个来自微博客户端程序的请求
     收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
     @param request 具体的请求对象
     */
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        if (request is(WBProvideMessageForWeiboRequest)) {
            
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
}

