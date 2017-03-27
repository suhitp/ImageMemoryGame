//
//  UIView+Extension.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 27/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

extension UIView {

    func startLoadingIndicator()
    {
        stopLoadingIndicator()
        
        let loaderView = UIView()
        loaderView.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        loaderView.tag = 8888
        loaderView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        loaderView.layer.cornerRadius = 5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        spinner.translatesAutoresizingMaskIntoConstraints  = false
        spinner.hidesWhenStopped = true
        loaderView.addSubview(spinner)
        addSubview(loaderView)
        loaderView.center = self.center
        
        self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem:loaderView , attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0) )
        self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: loaderView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0) )
        self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 27) )
        self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 27) )
        spinner.startAnimating()
        self.isUserInteractionEnabled = false
    }
    
    func stopLoadingIndicator()
    {
        if let loaderView = self.viewWithTag(8888) {
            for activityView in loaderView.subviews {
                if let view = activityView as? UIActivityIndicatorView {
                    view.stopAnimating()
                }
            }
            loaderView.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }


}
