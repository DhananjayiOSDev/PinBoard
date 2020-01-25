//
//  MVAPIWrapper.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import Foundation

class MVAPIWrapper: NSObject {
    
    var downloadTask:DownloadTask?
    
    func getDownloadData(from url: URL, completion: @escaping (Data?, Error?) -> Void, progress: @escaping (Double) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let cacheData = MVDownloadCache.getDataObject(forKey: url.absoluteString as NSString) {
                completion(cacheData as Data, nil)
                return
            }
            self.downloadTask = MVNetworkHandler.shared.download(request: URLRequest(url: url))
            self.downloadTask?.completionHandler = { result in
                switch result{
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                case .success(let data):
                    MVDownloadCache.setDataObject(data: data as NSData, forKey: url.absoluteString as NSString)
                    completion(data, nil)
                }
            }
            self.downloadTask?.progressHandler = { progressVal in
                progress(progressVal)
            }
            self.downloadTask?.resume()
        }
    }
    
    func cancelCurrentDownload(from url: URL) {
        MVNetworkHandler.shared.cancelCurrentDownload(url: url)
    }
    
}
