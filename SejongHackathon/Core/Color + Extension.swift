//
//  Color + Extension.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import UIKit

extension UIColor {
    static let pointColor : UIColor = {
        return UIColor(named: "pointColor") ?? .white
    }()
    static let shadowColor : UIColor = {
        return UIColor(named: "shadowColor") ?? .white
    }()
}
