//
//  MVDownloadCache.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

let downloadCache = NSCache<NSString, NSData>()

class MVDownloadCache: NSObject {

    static func setDownloadCacheLimit(totalLimit:Int? = MVConstants.defaultCacheLimit, countLimit:Int? = MVConstants.defaultCacheLimit,isEvictDiscarbleContent:Bool? = false) {
        
        if let totalLimit = totalLimit {
            downloadCache.totalCostLimit = totalLimit
        }
        if let countLimit = countLimit {
            downloadCache.countLimit = countLimit
        }
        
        if let isEvictDiscarbleContent = isEvictDiscarbleContent {
            downloadCache.evictsObjectsWithDiscardedContent = isEvictDiscarbleContent
        }
    }
    
   static func setDataObject(data: NSData, forKey key:NSString){
        downloadCache.setObject(data, forKey: key)
    }
    
   static func getDataObject(forKey key: NSString) -> NSData?{
        return downloadCache.object(forKey: key)
    }
    
}
