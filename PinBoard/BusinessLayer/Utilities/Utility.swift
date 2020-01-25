//
//  Utility.swift
//  PinBoard
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    class var sharedInstance: Utility
    {
        //creating Shared Instance
        struct Static
        {
            static let instance: Utility = Utility()
        }
        return Static.instance
    }
    
    /// function returns the main stroyboard object
    static func getMainStroryBoard() -> UIStoryboard{
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        return stroyboard
    }
    
    class func setCasaTourNavigationBarForView(_ vc: UIViewController) {
        vc.navigationItem.hidesBackButton = false
        vc.navigationController?.navigationBar.isTranslucent = false
        let appIconImage = UIImageView.init(image: UIImage.init(named: "mind_valley"))
        let marginX = (vc.navigationController!.navigationBar.frame.size.width / 2) - (150 / 2)
        appIconImage.frame = CGRect.init(x: marginX, y: 5, width: 150, height: 30)
        appIconImage.contentMode = .scaleAspectFit
        vc.navigationController?.navigationBar.addSubview(appIconImage)
        
        vc.navigationController?.navigationBar.barStyle = .default
        if let statusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbarView.backgroundColor = .white
        }
    }
    
    class func formatDate(strDate :String) ->String
    {
        if strDate == "" {
            return ""
        }
        var dateString : String = ""
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        if let date = dateFormatter.date(from: strDate) {
            dateFormatter.dateFormat = "dd.MMM yyyy h:mm a"
            dateFormatter.locale = tempLocale // reset the locale
            dateString = dateFormatter.string(from: date)
        }else {
            dateString = strDate
        }
        
        return dateString
    }
}
