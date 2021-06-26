//
//  Model.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit
import Foundation

struct Movie : Codable{
    
    var adult : Bool?
    var backdrop_path : String?
    var id : Int?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var release_date : String?
    var title : String?
    var video : Bool?
    var vote_average : Double?
    var vote_count : Int?
    
}

struct Dates : Codable{
    
    var maximum : String?
    var minimum : String?
    
}



struct  MovieDetail : Codable{
    
    var id : String?
    var iso_639_1 : String?
    var iso_3166_1 : String?
    var key : String?
    var name : String?
    var YouTube : String?
    var size : Int?
    var type : String?

}
