//
//  XQWBUser.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/13.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import YYModel
/// 微博用户模型
class XQWBUser: NSObject {
    
    // 基本数据类型和private不能设置为 kvc
    /// 用户UID
    var id: Int64 = 0
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = 0
    /// 会员等级 0-6
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
}

}
