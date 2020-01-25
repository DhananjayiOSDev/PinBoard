//
//  PBAPIRequestManager.swift
//  PinBoard
//
//  Created by Dhananjay on 23/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit
import MVDownloader
import SwiftyJSON

class PBAPIRequestManager: NSObject {
    
    typealias onCompletionHandler = (_ pinsListArray: [PBPinsListModel]?,_ error:Error?) -> Void
    
    static func getAllPinsList(reqUrl:String, completion:@escaping onCompletionHandler) {
        if let requestUrl = URL.init(string: reqUrl) {
            MVDownloader.downloadJsonData(from: requestUrl) { (responseData, error) in
                if error != nil {
                    completion(nil,error)
                    return
                }
                
                do {
                    if let response = responseData {
                        let json = try JSON.init(data: response)
                        print(json.array)
                        var pinsListArray = [PBPinsListModel]()
                        for jsonObj in json.array! {
                            let pinsModel = try JSONDecoder().decode(PBPinsListModel.self, from: jsonObj.rawData())
                            pinsListArray.append(pinsModel)
                        }
                        
                        
                        completion(pinsListArray,nil)
                    }
                } catch {
                    
//                    completion(nil, NSError.generalError(domain: url.absoluteString, comment: "Json parsing error"))
                }
                
                
            }
            
        }
    }
}
