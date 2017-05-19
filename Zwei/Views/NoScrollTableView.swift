//
//  NoScrollTableView.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 15/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit

class NoScrollTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        get {
            layoutIfNeeded()
            return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
