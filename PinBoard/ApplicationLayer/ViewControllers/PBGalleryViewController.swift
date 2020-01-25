//
//  ViewController.swift
//  PinBoard
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import Toast_Swift

class PBGalleryViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tblGalleryPins: UITableView!
    
    //MARK: Variables
    var pinDetailsArray = [PBPinsListModel]()
    var totalPinsListCount = 100
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(refreshPinDetails(_:)),for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isHidden = false
        Utility.setCasaTourNavigationBarForView(self)
        
        self.tblGalleryPins.addSubview(self.refreshControl)
        self.tblGalleryPins.tableFooterView = UIView()
        self.callToGetPinsListFromServer()

    }
    
    //MARK: WS API function
    // Retrived the latest pins details from server
    //Parameters : isDataRefreshed : This parameter is used to indentify WS is called from refresh control.
    func callToGetPinsListFromServer(isDataRefreshed:Bool = false) {
        PBAPIRequestManager.getAllPinsList(reqUrl: PBConstants.kWsGetPinsListingUrl) { (pinsListArray, error) in
            if error != nil {
                //show error
                return
            }
            if isDataRefreshed {
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(PBConstants.kToastDataFetched)
                    self.refreshControl.endRefreshing()
                    self.tblGalleryPins.reloadData()
                });
                
                return
            }
            if pinsListArray!.count > 0 {
                for pins in pinsListArray! {
                    self.pinDetailsArray.append(pins)
                }
                
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(PBConstants.kToastDataFetched)
                    self.tblGalleryPins.reloadData()
                });
                
            }
        }
    }
    
    // MARK: - UIRefreshControl
    @objc func refreshPinDetails(_ refreshControl: UIRefreshControl) {
        self.callToGetPinsListFromServer(isDataRefreshed: true)
    }

}

// MARK:- TableView Delegates
extension PBGalleryViewController:UITableViewDelegate,UITableViewDataSource {
    //MARK: - TableviewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pinDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create seperate list item cell for listing of pins.
        let listItemCell : PBPinDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: PBPinDetailsTableViewCell.cellIDForPinDetails, for: indexPath)as! PBPinDetailsTableViewCell
        
        let pinDetailsModel = self.pinDetailsArray[indexPath.row]
        listItemCell.setDataForCell(pinDetailsModel: pinDetailsModel)
        listItemCell.btnDownload.tag = indexPath.row
        listItemCell.pinDetailsArray = self.pinDetailsArray
        
        if indexPath.row == (self.pinDetailsArray.count - 1) && self.pinDetailsArray.count < totalPinsListCount {
            self.callToGetPinsListFromServer()
        }
        
        return listItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let pinDetailsModel = self.pinDetailsArray[indexPath.row]
    }
}
