//
//  MenuViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 17/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuView: MenuView!
    var menu:[String]? {
        didSet {
            reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let v = loadFromXib(XIB.MenuView.rawValue) as? MenuView {
            menuView = v
            menuView?.menuTableView.dataSource = self
            menuView?.menuTableView.delegate = self
            
            setupView()
            setupMenu()
            
            view = menuView
        }
    }
    
    func setupView() {
        
    }
    
    func setupMenu() {
        menu = [
            "Home",
            "Calendar",
            "Search",
            "Favorites"
        ]
    }
    
    func reloadData() {
        menuView?.menuTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menu?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let c = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = c
        }else{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = menu?[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath)")
        performSegue(withIdentifier: "TestSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
