//
//  BurgerMenuVC.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 27/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit

class BubbleCell: UITableViewCell {
    
    @IBOutlet weak var avatarChannelImage: UIImageView!
    @IBOutlet weak var isSelectedCircleImage: UIImageView!
    @IBOutlet weak var channelShortNameLabel: UILabel!
    @IBOutlet weak var separatorSection: UIView!
}

class BurgerMenuVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var user: User!
    var channels: [Channel] = []
    var selectedCell: IndexPath = IndexPath(row: 0, section: 0)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}

extension BurgerMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        } else {
            
            // return self.channels.count
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BubbleCell = tableView.dequeueReusableCell(withIdentifier: "bubbleCell") as! BubbleCell
        
        if indexPath.section == 0 {
            
            cell.avatarChannelImage.image = UIImage(named: "people-picture")
            cell.channelShortNameLabel.isHidden = true
            cell.separatorSection.isHidden = false
            cell.isSelectedCircleImage.isHidden = true
        } else {
            
            cell.avatarChannelImage.image = UIImage(named: "circle-empty-picture")
            cell.channelShortNameLabel.isHidden = false
            cell.channelShortNameLabel.text = String(indexPath.row)
            cell.separatorSection.isHidden = true
            cell.isSelectedCircleImage.isHidden = true
        }
        
        // If cell is selected
        if indexPath.section == self.selectedCell.section && indexPath.row == self.selectedCell.row {
            
            cell.isSelectedCircleImage.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCell = indexPath
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}
