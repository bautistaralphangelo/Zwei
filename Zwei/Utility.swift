//
//  Utility.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 09/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation

enum Segue: String {
    case SplashToHomeSegue = "SplashToHomeSegue"
    case ShowMenuSegue = "ShowMenuSegue"
    case MovieDetailsSegue = "MovieDetailsSegue"
    case SeriesDetailsSegue = "SeriesDetailsSegue"
}

enum XIB: String {
    case SplashXIBName = "SplashScreen"
    case ShowsTableView = "ShowsTableView"
    case MovieDetailsView = "MovieDetailsView"
    case SeriesDetailsView = "SeriesDetailsView"
    case MenuView = "MenuView"
}
