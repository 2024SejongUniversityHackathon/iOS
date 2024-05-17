//
//  CategoryViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import SnapKit
import UIKit

class CategoryViewController : UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
