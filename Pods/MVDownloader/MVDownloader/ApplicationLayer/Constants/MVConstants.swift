//
//  MVConstants.swift
//  MVDownloader
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

enum fileType {
    case json
    case xml
    case image
    case PDF
    case video
}

class MVConstants: NSObject {

    static let defaultCacheLimit  = 1024 * 1024 * 100 // 100 MB
}
