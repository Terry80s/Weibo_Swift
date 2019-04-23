//
//  Utility.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/13.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import Foundation

class Utility{
 static func updateTimeToCurrennTime(timeStampStr: String) -> String {
        let timeStr = timeStampStr

            let formatter = DateFormatter()
            formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
            formatter.locale = Locale(identifier: "en")
            
            let createDate = formatter.date(from: timeStr)! //创建一个日历类
            let calendar = Calendar.current
            var result = ""
            var formatterSr = "HH:mm"
            
            if calendar.isDateInToday(createDate) { //今天
                let interval = Int(NSDate().timeIntervalSince(createDate))  //比较两个时间的差值
                if interval < 60 {
                    result = "刚刚"
                }else if interval < 60 * 60 {
                    result = "\(interval/60)分钟前"
                }else if interval < 60 * 60 * 24 {
                    result = "\(interval / (60 * 60))小时前"
                }
            }else if calendar.isDateInYesterday(createDate) {  //昨天
                formatterSr = "昨天 " + formatterSr
                formatter.dateFormat = formatterSr
                result = formatter.string(from: createDate)
            }else {
                //该方法可以获取两个时间之间的差值
                let comps = calendar.dateComponents([Calendar.Component.year], from: createDate, to: Date())
                if comps.year! >= 1 {  //更早时间
                    formatterSr = "yyyy-MM-dd " + formatterSr
                }else { //一年以内
                    formatterSr = "MM-dd " + formatterSr
                }
                
                formatter.dateFormat = formatterSr
                result = formatter.string(from: createDate)
            }
            return result    //timeLabel是显示时间的标签

    }
}
