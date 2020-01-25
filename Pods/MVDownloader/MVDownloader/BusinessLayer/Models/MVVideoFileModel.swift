//
//  MVVideoFileModel.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class MVVideoFileModel: NSObject {
    var apiWrapperInstance = MVAPIWrapper()
    
    func downloadVideo(from url: URL,videoName:String, completion: @escaping (URL?, Error?) -> Void) {
        
        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(videoName).mp4")
            do {
                try data?.write(to: pathURL, options: .atomic)
            }catch{
                print("Error while writting Video File")
            }
            
            completion(pathURL, nil)
        }) { (progress) in
            
        }
    }
}
