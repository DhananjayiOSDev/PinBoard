//
//  MVFileModel.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class MVFileModel: NSObject {
    
    var apiWrapperInstance = MVAPIWrapper()
    
    func downloadAnyFile(from url: URL, completion: @escaping (Data?, Error?) -> Void) {        
        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }) { (progress) in
            
        }
    }
    
    func downloadPDFFile(from url: URL,pdfFileName:String, completion: @escaping (URL?, Error?) -> Void) {

        apiWrapperInstance.getDownloadData(from: url, completion: { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(pdfFileName).pdf")
            do {
                try data?.write(to: pathURL, options: .atomic)
            }catch{
                print("Error while writting PDF File")
            }
            
            completion(pathURL, nil)
        }) { (progress) in
            //print(progress)
        }
    }
    
}
