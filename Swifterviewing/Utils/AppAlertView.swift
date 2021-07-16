//
//  AppAlertView.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Foundation

class AppAlertView: NSObject {
    // Singleton.
    class var sharedInstance: AppAlertView {
        struct Static {
            static let instance: AppAlertView = AppAlertView()
        }
        return Static.instance
    }
    private override init() {}
    // show alert.
    static func showAlertViewWithOKButton(vc : UIViewController, titleString : String , messageString: String) ->()
    {
        let alertView = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (alert) in
            vc.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(alertAction)
        vc.present(alertView, animated: true, completion: nil)

    }
}
