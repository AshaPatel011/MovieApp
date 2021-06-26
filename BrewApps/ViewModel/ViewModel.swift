//
//  ViewModel.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import Alamofire

//MARK: delegate ---------------------------------------------------------

protocol MovieHelperParserDelegate: class {
    
    func Success(arrMovie: [Movie])
    func Search(arrMovie: [Movie])
    func Delete(arrMovie: [Movie],index: IndexPath)
    func Failed(strerrormessage: String)
    
}

class MovieHelper_Parser: NSObject {
    
    //MARK: properties ---------------------------------------------------------
    
    weak var delegate: MovieHelperParserDelegate?
    var arrMovie : [Movie]?
    var arrSearchMovie : [Movie]?
    
    //MARK: others ---------------------------------------------------------
    
    func initWith(helperDelegate: MovieHelperParserDelegate) {
        delegate = helperDelegate
    }
    
    func getMovieDelete(_ index : IndexPath){
        arrMovie?.remove(at: index.row)
        arrSearchMovie = arrMovie
        self.delegate?.Delete(arrMovie: arrMovie ?? [Movie](),index: index)
    }
    
    func getMovieSearch(_ text : String = ""){
        if(text.lowercased().isEmpty){
            arrSearchMovie = arrMovie
        }
        else{
            arrSearchMovie = arrMovie?.filter({($0.title ?? "").lowercased().contains(text.lowercased()) || ($0.overview ?? "").lowercased().contains(text.lowercased())})
        }
        
        self.delegate?.Search(arrMovie: self.arrSearchMovie ?? [Movie]())

    }
    
    func getMovieList(viewController: UIViewController) {
       
        AppManager.sharedIntance.PostMethodAPi(request: constantUrl, httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in
            
            if response["success"] as? Bool ?? true == false{
                self.delegate?.Failed(strerrormessage: response["status_message"] as? String ?? strErrorMessage)
                return
            }

                do{
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response["results"] as! [AnyObject], options: .prettyPrinted)
                    print(jsonData)
                    let jsonDecoder = JSONDecoder()
                    self.arrMovie = try jsonDecoder.decode([Movie].self, from: jsonData)
                    self.arrSearchMovie = self.arrMovie
                    // api success
                    self.delegate?.Success(arrMovie: self.arrMovie ?? [Movie]())
                    
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
