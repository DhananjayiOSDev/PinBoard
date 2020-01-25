//
//  MVDownloader.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

public class MVDownloader: NSObject {

   public static func configureCacheLimit(totalLimit:Int, countLimit:Int, isEvictDiscarbleContent:Bool? = false) {
        MVDownloadCache.setDownloadCacheLimit(totalLimit: totalLimit, countLimit: countLimit, isEvictDiscarbleContent:isEvictDiscarbleContent)
    }
    
    public static func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {        
        MVImageModel().downloadImage(from: url, completion: { (image, error) in
            completion(image, error)
        }) { (progressVal) in
            //print("Image Download Progress",progressVal)
        }
    }
    
    public static func downloadImage(from url: URL, imageView: UIImageView, placeHolder: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async() {
            imageView.image = UIImage(named: placeHolder)
        }
        
        MVImageModel().downloadImage(from: url, completion: { (image, error) in
            DispatchQueue.main.async() {
                if let downloadedImage = image {
                    imageView.image = downloadedImage
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }) { (progressVal) in
            //downloadButton.downloadPercent = CGFloat(progressVal)
        }
        
    }
    
    public static func downloadJsonDictionary(from url: URL, completion: @escaping ([Dictionary<String,Any>]?, Error?) -> Void) {
        MVJsonFileModel().downloadJsonDictionary(from: url) { (jsonDict, error) in
            completion(jsonDict, error)
        }
    }
    
    public static func downloadJsonData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        MVJsonFileModel().downloadJsonData(from: url) { (jsonData, error) in
            completion(jsonData, error)
        }
    }

    public static func downloadPDFFile(from url: URL,fileName:String, completion: @escaping (URL?, Error?) -> Void) {
        MVFileModel().downloadPDFFile(from: url, pdfFileName: fileName) { (pdfFileUrl, error) in
           completion(pdfFileUrl, error)
        }
    }
    
    public static func downloadAnyFile(from url: URL,fileName:String, completion: @escaping (Data?, Error?) -> Void) {
        MVFileModel().downloadAnyFile(from: url) { (data, error) in
            completion(data, error)
        }
    }
    
    public static func cancelCurrentDownload(from url: URL) {
        MVAPIWrapper().cancelCurrentDownload(from: url)
    }
    
}
