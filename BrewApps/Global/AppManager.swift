//
//  AppManager.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - typealias  ---------------------------------------------------------

// api success
typealias apiCalledSuccess = (_ response: [String : AnyObject]) -> ()
// api failure
typealias apiCalledFailure = (_ error: Error) -> ()
// api progrss indocator
typealias progressIndicator = (_ response: Float) -> ()

class AppManager: NSObject {
    
    static let sharedIntance = AppManager()
    
    func PostMethodAPi(request: String,httpMethod: Alamofire.HTTPMethod, params: [String:AnyObject], fromVC: UIViewController, apiSuccess: @escaping apiCalledSuccess, apiFailuer: @escaping apiCalledFailure) {
        
        AF.request(request, method:.get,encoding: URLEncoding.default) .responseJSON { (response) in
            print(response)

            switch response.result {
            case let .success(result):
               // the decoded result of type 'Result' that you received from the server.
             print("Result is: \(result)")
             apiSuccess(result as? [String : AnyObject] ?? [String : AnyObject]())
            case let .failure(error):
               // Handle the error.
             print("Error description is: \(error.localizedDescription)")
             apiFailuer(error)

            }
        }
    }
}




