//
//  ProfileTableViewController.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/08.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit

class ProfileTableViewController : BViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "我"
        
        //setupUI()
    }
}
