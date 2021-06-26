//
//  Extention.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import UIKit

//MARK: UIView ---------------------------------------------------------

extension UIView{
    
    func setCorner(_ radius : CGFloat = 10.0){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
}

//MARK: UIImageView ---------------------------------------------------------

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse!, data: Data!, error: Error!) -> Void in
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
