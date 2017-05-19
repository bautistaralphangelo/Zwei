//
//  UIViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func loadFromXib(_ name: String) -> UIView? {
        let xibs = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        if let view = xibs?.first as? UIView {
            return view
        }
        
        return nil
    }
    
    func showMenu(){
        performSegue(withIdentifier: Segue.ShowMenuSegue.rawValue, sender: self)
    }
    
}
