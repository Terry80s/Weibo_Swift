//
//  XQWBStatusPicture.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/13.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import YYModel
class XQWBStatusPicture: NSObject {
    /// 缩略图地址
    var thumbnail_pic: String? {
        didSet {
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}
