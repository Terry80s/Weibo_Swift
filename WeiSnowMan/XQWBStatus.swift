//
//  XQWBStatus.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/12.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import YYModel
// 微博数据模型
class XQWBStatus: NSObject {
    
    /// id
    var id: Int64 = 0
    /// 微博信息内容
    var text: String?
    /// 用户模型
    var user: XQWBUser?
    
    /// 被转发的原创微博
    var retweeted_status: XQWBStatus?
    
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 点赞数
    var attitudes_count: Int = 0
    /// 缩略图配图数组 key: thumbnail_pic
    var pic_urls: [XQWBStatusPicture]?
    //var pic_urls: [String]?
    
    /// 微博创建时间
    var created_at: String? {
        didSet {
            //createDate = Date.xq_sinaDate(string: created_at ?? "")
        }
    }
    
    /// 微博创建日期
    var createDate: Date?
    
    /// 微博来源
    var source: String?
    
    
    // 重写description
    override var description: String {
        return yy_modelDescription()
    }
    // 映射数组
    class func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["pic_urls": XQWBStatusPicture.self]
    }
}

