//
//  NavigationPanelController.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/24/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit
import RNNavigationDrawerController

class NavigationPanelController: UIViewController, RNNavigationPanelController {
    
    static var savedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: RNNavigationPanelControllerDelegate?
    
    var navigationMenuItems: [RNNavigationMenuItem] {
        return menuItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension NavigationPanelController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellId, for: indexPath)
        
        if NavigationPanelController.savedIndexPath == indexPath {
            cell.textLabel?.textColor = UIColor.orange
        }
        
        cell.textLabel?.text = navigationMenuItems[indexPath.row].displayTitle
        
        return cell
        
    }
    
}

extension NavigationPanelController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NavigationPanelController.savedIndexPath = indexPath
        delegate?.didSelect(menuItem: navigationMenuItems[indexPath.row])
    }
    
}
