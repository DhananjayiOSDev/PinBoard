//
//  MVJsonFileModel.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class MVJsonFileModel: NSObject {
    
    var apiWrapperInstance = MVAPIWrapper()
    
    func downloadJsonData(from url: URL, completion: @escaping (Data? , Error?) -> Void) {
        
        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
            }
            
            if let jsonData = data {
                completion(jsonData, nil)
            }
        }) { (progress) in
            
        }
    }
    
    func downloadJsonDictionary(from url: URL, completion: @escaping ([Dictionary<String,Any>]?, Error?) -> Void) {
        
        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<Dictionary< String, Any>>
                    completion(json, nil)
                } catch {
                    completion(nil, NSError(domain: url.absoluteString, code: 400, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Parsing Error", comment: "Unable to parse JSON data")]))
                }
            }
        }) { (progress) in
            
        }
    }
}
