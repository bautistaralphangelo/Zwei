//
//  ZReplaceUIStoryboardSegue.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit

class ZReplaceUIStoryboardSegue: UIStoryboardSegue {

    override func perform() {
        self.source.navigationController?.pushViewController(self.destination, animated: false)
    }
    
}
