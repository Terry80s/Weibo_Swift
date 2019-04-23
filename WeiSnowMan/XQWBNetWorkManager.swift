//
//  XQWBNetWorkManager.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/12.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import AFNetworking

class XQWBNetWorkManager: AFHTTPSessionManager{
     static let shared = XQWBNetWorkManager()
    var accessToken:String? = "2.009oPyUC0krsEl900c2bbac6QbhudC" // 这个就是我们从接口测试工具中得到的access_token
    
    // 请求方式的枚举
    enum XQWBHTTPMethod {
        case GET
        case POST
    }
    
    /// 封装 GET/POST 请求
    ///
    /// - Parameters:
    ///   - method: 请求方式
    ///   - URLString: url
    ///   - parameters: 参数
    ///   - completion: 回调
    func request(method:XQWBHTTPMethod = .GET, URLString: String,  parameters:[String:Any], completion:@escaping (_ json:Any?, _ isSuccess:Bool)->()) {
        
        // 成功回调
        let success = { (tast:URLSessionDataTask, json:Any?)->() in
            completion(json, true)
        }
        // 失败回调
        let failure = { (tast:URLSessionDataTask?, error:Error)->() in
            // 处理403
            if (tast?.response as? HTTPURLResponse)?.statusCode == 403 {
                //  print("token过期")
                //  TODO:发送通知,重新登录(谁接受谁处理)
                print("发送通知,重新登录(谁接受谁处理)\(error)")
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: XQWBUserShouldLoginNotification), object: nil)
            }
            print("网络请求错误\(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    // 负责拼接token
    func tokenRequest(method:XQWBHTTPMethod = .GET, URLString: String,  parameters:[String:Any]?, completion:@escaping (_ json:Any?, _ isSuccess:Bool)->())  {
        
        guard let token = accessToken else {
            // token 不存在
            // FIXME: 发送通知,重新登录(谁接受谁处理)
            completion(nil, false)
            return
        }
        // 判断参数字典是否存在
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        parameters!["access_token"] = token
        // 调用request  发起真正的请求
        request(method: method, URLString: URLString, parameters: parameters!, completion: completion)
    }
    
    /// 加载微博数据
    ///
    /// - Parameters:
    ///   - since_id: 最小的
    ///   - max_id: 最大的
    ///   - completion: 回调 [list:数据, isSuccess:是否成功]
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion:@escaping (_ list:[[String:AnyObject]]?, _ isSuccess:Bool)->())  {
        // 加载微博数据
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id": since_id, "max_id":max_id > 0 ? max_id - 1 : 0]
        
        
        tokenRequest(URLString: urlStr, parameters: params) { (json, isSuccess) in
            let tempJson = json as AnyObject
            let result = tempJson["statuses"] as? [[String:AnyObject]]
            
            completion(result, isSuccess)
        }
    }
}
