//
//  DemoViewController.swift
//  CustomTabbar
//
//  Created by Tuan Mai A. on 5/8/17.
//  Copyright © 2017 Tuan Mai A. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    var vcl: UIColor = UIColor.blue

    @IBOutlet weak var tabbar: TabbarCustom!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = vcl
        
    }

}
