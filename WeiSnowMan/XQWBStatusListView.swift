//
//  XQWBStatusListView.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/12.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

class XQWBStatusListViewModel{

    // 模型数组懒加载
    lazy var statusList = [XQWBStatus]()
    // 上拉次数限制
    fileprivate var pullupErrorTime = 0
    // 上拉次数限制
    fileprivate var maxPullTryTimes = 5
    // 用来加载网络数据,以及回调
    func loadStatus(pullup:Bool, completion:@escaping (_ isSuccess:Bool, _ shouldRefresh:Bool)->()) {
        
        if pullup && pullupErrorTime > maxPullTryTimes{
            completion(true, false)
            return
        }
        // since_id 下拉,去最大的(第一个)
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        let max_id = pullup ? (statusList.last?.id ?? 0) : 0
        XQWBNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 1.字典转模型
            guard let array = NSArray.yy_modelArray(with: XQWBStatus.self, json: list ?? []) as? [XQWBStatus] else {
                completion(isSuccess, false)
                return
            }
            if pullup {
                // 上拉
                self.statusList += array
            }else {
                // 下拉刷新
                self.statusList = array + self.statusList;
            }
            if pullup && array.count == 0 {
                self.pullupErrorTime += 1
                completion(isSuccess, false)
            }else {
                completion(isSuccess, true)
            }
        }
    }

}
