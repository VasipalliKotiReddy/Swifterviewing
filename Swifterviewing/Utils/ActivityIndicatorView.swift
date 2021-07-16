//
//  ActivityIndicatorView.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorView:NSObject{
    
    static let sharedInstance = ActivityIndicatorView()
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    
   //MARK: Show customized activity indicator,
    func showActivityIndicator(targetView: UIView) {
        
        DispatchQueue.main.async {
            self.container.frame = targetView.frame
            self.container.center = targetView.center
            self.container.backgroundColor = self.UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
            
            self.loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
            self.loadingView.center = targetView.center
            self.loadingView.backgroundColor = self.UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.activityIndicator.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
            self.activityIndicator.style = UIActivityIndicatorView.Style.large
            self.activityIndicator.center = CGPoint(x:self.loadingView.frame.size.width / 2, y:self.loadingView.frame.size.height / 2);
            
            self.loadingView.addSubview(self.activityIndicator)
            self.container.addSubview(self.loadingView)
            targetView.addSubview(self.container)
            self.activityIndicator.startAnimating()
            targetView.isUserInteractionEnabled = false
            //UIApplication.shared.beginIgnoringInteractionEvents()
        }
       
    }
    
    //MARK: Hide activity indicator
 
    func hideActivityIndicator(targetView: UIView) {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
            targetView.isUserInteractionEnabled = true
            //UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

