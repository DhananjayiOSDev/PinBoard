//
//  PBPinDetailsTableViewCell.swift
//  PinBoard
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import MVDownloader

class PBPinDetailsTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var imgPinImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserProfileIcon: UIImageView!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLikesCount: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    var pinDetailsArray = [PBPinsListModel]()
    
    static let cellIDForPinDetails: String = "PinDetailsCell"
    
    // MARK: ViewLife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Class Functions
    func setDataForCell(pinDetailsModel:PBPinsListModel) {
        
        self.downloadPinImage(pinDetails: pinDetailsModel)
        
        // User name for pins user
        if let userName = pinDetailsModel.user?.name {
            self.lblUserName.text = userName
        }
    
        self.lblCategories.text = pinDetailsModel.categoriesStr
        
        //User profile image
        if let userImageUrl = pinDetailsModel.user?.profileImage?.small {
            if let url =  URL.init(string: userImageUrl) {
                    MVDownloader.downloadImage(from: url, completion: { (image, error) in
                        if error == nil {
                            DispatchQueue.main.async(execute: {
                               self.imgUserProfileIcon.image = image
                            });
                        }
                    })
            }
        }
        
        // Date for pin image posting
        if let dateString = pinDetailsModel.createdAt {
            self.lblDate.text = Utility.formatDate(strDate: dateString)
        }
        
        //Total like count
        if let likeCount = pinDetailsModel.likes {
            self.lblLikesCount.text = "\(likeCount)"
        }
    }
    
    //Seperate function for downloading main pin image and assigned to respective imageview.
    func downloadPinImage(pinDetails:PBPinsListModel) {
        switch pinDetails.downloadState {
        case .Downloading:
            self.btnDownload.isHidden = false
            self.btnDownload.isSelected = true
        case .Cancelled:
            self.btnDownload.isHidden = false
            self.btnDownload.isSelected = false
        case .Downloaded:
            self.btnDownload.isHidden = true
            self.btnDownload.isSelected = false
        }
        
        // Get the Pins main image url from pin details model and download the respective image with MVDownloader
        if let fullImageUrl = pinDetails.urls!.small {
            if let url =  URL.init(string: fullImageUrl) {
                MVDownloader.downloadImage(from: url, imageView: self.imgPinImage, placeHolder: "mind_valley") { (status) in
                    //                        if status {
                    pinDetails.downloadState = .Downloaded
                    self.btnDownload.isHidden = true
                    //                        }
                }
            }
        }
    }
    
    //IBAction function for toggling the Cancel & Download pin images.
    @IBAction func toggleDownloadCancelClicked(_ sender: UIButton) {
        let pinDetailsModel = self.pinDetailsArray[sender.tag]
        if sender.isSelected == false {
            sender.isSelected = true
            self.downloadPinImage(pinDetails: pinDetailsModel)
        }else {
            sender.isSelected = false
            if let fullImageUrl = pinDetailsModel.urls!.small {
                if let url =  URL.init(string: fullImageUrl) {
                    MVDownloader.cancelCurrentDownload(from: url)
                    pinDetailsModel.downloadState = .Cancelled
                }
            }
        }
        
    }
    

}
