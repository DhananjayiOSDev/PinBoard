//
//  PBConstants.swift
//  PinBoard
//
//  Created by Dhananjay on 23/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class PBConstants: NSObject {
    
    // API Url
    static let kWsGetPinsListingUrl        =   "http://pastebin.com/raw/wgkJgazE"
    
    static let cacheCostLimit              =    1024 * 1024 * 100 // 100 MB
    static let cacheCountLimit             =    100
    
    static let kToastDataFetched           =    "Latest Pins Fetched!!"
}
