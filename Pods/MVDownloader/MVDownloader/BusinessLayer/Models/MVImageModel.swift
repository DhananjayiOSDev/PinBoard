//
//  MVImageModel.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class MVImageModel: NSObject {
    
    var apiWrapperInstance = MVAPIWrapper()
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void , progress : @escaping (Double) -> Void) {
        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            if let imageData = data {
                let returnImage = UIImage(data: imageData)
                completion(returnImage, nil)
            }
        }) { (taskProgress) in
            print("Current Task Progress",taskProgress)
            progress(taskProgress)
        }
    }
}
