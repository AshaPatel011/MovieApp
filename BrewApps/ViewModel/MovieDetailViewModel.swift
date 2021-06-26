//
//  MovieDetailViewModel.swift
//  BrewApps
//
//  Created by Asha on 26/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import Alamofire

//MARK: delegate ---------------------------------------------------------

protocol MovieDetailHelperParserDelegate: class {
    
    func Success(arrMovieDetail: [MovieDetail])
    func Failed(strerrormessage: String)
    
}

class MovieDetailHelper_Parser: NSObject {
    
    //MARK: properties ---------------------------------------------------------
    
    weak var delegate: MovieDetailHelperParserDelegate?
    var arrMovieDetail : [MovieDetail]?
    
    //MARK: others ---------------------------------------------------------
    
    func initWith(helperDelegate: MovieDetailHelperParserDelegate) {
        delegate = helperDelegate
    }
    
    func getMovieList(viewController: UIViewController, id : Int) {
       
        let url = BaseURL + "\(id)" + "/videos?api_key=" + api_key
        
        AppManager.sharedIntance.PostMethodAPi(request: url, httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in

                if response["success"] as? Bool ?? true == false{
                    self.delegate?.Failed(strerrormessage: response["status_message"] as? String ?? strErrorMessage)
                    return
                }
                do{
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response["results"] as! [AnyObject], options: .prettyPrinted)
                    print(jsonData)
                    let jsonDecoder = JSONDecoder()
                    self.arrMovieDetail = try jsonDecoder.decode([MovieDetail].self, from: jsonData)
                    // api success
                    self.delegate?.Success(arrMovieDetail: self.arrMovieDetail ?? [MovieDetail()])
                    
                }catch let error{
                    print(error)
                }

        }) { (error) in
            DispatchQueue.main.async() {
                // api fail error
                self.delegate?.Failed(strerrormessage: strErrorMessage)
            }
            return
        }
    }
    
    
}
