//
//  BurgerMenuVC.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 27/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol BurgerMenuDelegate {
    
    func changeViewController(segue: String)
    func openChat(channel: Channel)
}

class BubbleCell: UITableViewCell {
    
    @IBOutlet weak var avatarChannelImage: UIImageView!
    @IBOutlet weak var isSelectedCircleImage: UIImageView!
    @IBOutlet weak var channelShortNameLabel: UILabel!
    @IBOutlet weak var separatorSection: UIView!
}

class UserCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var connectedImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
}

class BurgerMenuVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableViewChannel: UITableView!
    @IBOutlet weak var tableViewUser: UITableView!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    // Variables
    var user: User!
    var channels: ChannelList?
    var currentChannel: Channel?
    var selectedCell: IndexPath = IndexPath(row: 0, section: 0)
    var burgerMenuDelegate: BurgerMenuDelegate!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewChannel.tableFooterView = UIView()
        tableViewUser.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APIController.shared.listChannel(completionHandler: getListChannelCompletionHandler)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - IBAction
    
    @IBAction func OpenChannelTUI(_ sender: Any) {
        
        if let delegate = self.burgerMenuDelegate, let channel = self.currentChannel {
            
            self.dismiss(animated: true, completion: {
                
                delegate.openChat(channel: channel)
            })
        }
    }
    
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Completion handler
    
    
    /// Get all channel
    ///
    /// - Parameter channels: Channel list returned
    func getListChannelCompletionHandler(channels: ChannelList?) {
        
        if let channels = channels {
            
            self.channels = channels
            self.tableViewChannel.reloadData()
        }
    }
    
    /// Get current channel
    ///
    /// - Parameter channel: Channel returned
    func getCurrentChannelCompletionHandler(channel: Channel?) {
        
        if channel != nil {
            
            self.currentChannel = channel
            self.tableViewUser.reloadData()
        }
    }
}

extension BurgerMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // If tableview channel
        if tableView == self.tableViewChannel {
            
            // 3 section, one for privateMessageList, one for channels, one for creation channel
            return 3
        } else {
            
            // Only one different cell for displaying users
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If tableview channel
        if tableView == self.tableViewChannel {
            
            if section == 0 {
                
                // Return one cell to access private messages
                return 1
            } else if section == 1 {
                
                // Return number of channels available
                if self.channels?.channels != nil {
                    
                    return self.channels!.channels!.count
                } else {
                    
                    return 0
                }
            } else {
                
                // One cell to create a channel
                return 1
            }
        } else {
            
            // To modify later when adding private messages
            
            // If section selected of other tableview if an open channel, display info of open channel
            if self.selectedCell.section == 1 {
                
                // refresh current channel by getting selected channel an fetching info of that channel
                if let channel = self.channels?.channels?[selectedCell.row], channel.channel_url != nil, currentChannel == nil {
                    
                    APIController.shared.getChannel(channel_url: channel.channel_url!, completionHandler: getCurrentChannelCompletionHandler)
                }
                
                if self.currentChannel != nil && self.currentChannel?.participants != nil {
                    
                    return self.currentChannel!.participants!.count
                } else {
                    
                    return 0
                }
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // If tableview channel
        if tableView == self.tableViewChannel {
            
            let cell: BubbleCell = tableView.dequeueReusableCell(withIdentifier: "bubbleCell") as! BubbleCell
            
            if indexPath.section == 0 {
                
                cell.avatarChannelImage.image = UIImage(named: "people-picture")
                cell.channelShortNameLabel.isHidden = true
                cell.separatorSection.isHidden = false
                cell.isSelectedCircleImage.isHidden = true
            } else if indexPath.section == 1 {
                
                cell.avatarChannelImage.image = UIImage(named: "circle-empty-picture")
                cell.channelShortNameLabel.isHidden = true
                cell.separatorSection.isHidden = true
                cell.isSelectedCircleImage.isHidden = true
                
                if let cover = self.channels!.channels?[indexPath.row].cover_url {
                    
                    cell.avatarChannelImage.sd_setImage(with: URL(string: cover), placeholderImage: UIImage(named: "circle-empty-picture"))
                }
                
            } else {
                
                cell.avatarChannelImage.image = UIImage(named: "add-picture")
                cell.channelShortNameLabel.isHidden = true
                cell.separatorSection.isHidden = true
                cell.isSelectedCircleImage.isHidden = true
            }
            
            // If cell is selected
            if indexPath.section == self.selectedCell.section && indexPath.row == self.selectedCell.row {
                
                cell.isSelectedCircleImage.isHidden = false
            }
            
            return cell
        } else {
            
            let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserCell
            
            if let currentChannel = self.currentChannel {
                
                if let profile_url = currentChannel.participants?[indexPath.row].profile_url {
                    
                    cell.avatarImage.sd_setImage(with: URL(string: profile_url), placeholderImage: UIImage(named: "circle-empty-picture"))
                }
                
                if let nickname = currentChannel.participants?[indexPath.row].nickname {
                    
                    cell.nicknameLabel.text = nickname
                }
                
                if let is_online = currentChannel.participants?[indexPath.row].is_online {
                    
                    if is_online {
                        
                        cell.connectedImage.image = UIImage(named: "circle-connected-picture")
                    } else {
                        
                        cell.connectedImage.image = UIImage(named: "circle-offline-picture")
                    }
                }
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If tableview channel
        if tableView == self.tableViewChannel {
            
            // Set highlight row, unless if it's creation channel row
            if indexPath.section != 2 {
                
                self.selectedCell = indexPath
                self.tableViewChannel.reloadData()
            }
            
            if indexPath.section == 0 {
                
                // Group channel
                self.channelNameLabel.text = "Private Messages"
            } else if indexPath.section == 1 {
                
                if let channelName = self.channels?.channels![indexPath.row].name {
                    
                    self.channelNameLabel.text = channelName
                }
                
                // Open channel
                self.currentChannel = nil
                self.tableViewUser.reloadData()
            } else {
                
                if let delegate = self.burgerMenuDelegate {
                    
                    self.dismiss(animated: true, completion: {
                        
                        // Instantiate creationView for new channel
                        delegate.changeViewController(segue: "segueCreateChannel")
                    })
                }
            }
        } else {
            
            // Instantiate private messages here
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}
