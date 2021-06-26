//
//  MovieDetailsVC.swift
//  BrewApps
//
//  Created by Asha on 26/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsVC: UIViewController {

    //MARK: outlets ---------------------------------------------------------
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtDesc: UITextView!

    
    //MARK: properties ---------------------------------------------------------
    
    var dictMovie : Movie?
    var arrMovieDetail : [MovieDetail]?
    
    //MARK: properties ---------------------------------------------------------
    
    var movieDetailHelper_Parser = MovieDetailHelper_Parser()
    
    //MARK: view controller life cycle ---------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = dictMovie?.title
        lblTitle.text = dictMovie?.title
        lblDate.text = "Release Date:" + "\(dictMovie?.release_date ?? "")"
        txtDesc.text  = dictMovie?.overview

        getMovieDetailList()
        // Do any additional setup after loading the view.
    }
    
    //MARK: API calling ---------------------------------------------------------
    
    func getMovieDetailList()
    {
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
        
        movieDetailHelper_Parser.initWith(helperDelegate: self)
        movieDetailHelper_Parser.getMovieList(viewController: self, id: dictMovie?.id ?? 0)
    }
    
    //MARK: Others ---------------------------------------------------------

    
    func loadYoutube(videoID:String) {
        guard
        let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
        else { return }
        webView.load( URLRequest(url: youtubeURL) )
    }
    
}

//MARK: movie Detail Helper Delegate ---------------------------------------------------------

extension MovieDetailsVC : MovieDetailHelperParserDelegate {
    
    //success
    func Success(arrMovieDetail: [MovieDetail]) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.arrMovieDetail = arrMovieDetail
            self.loadYoutube(videoID: self.arrMovieDetail?.first?.key ?? "")
            print("Successfull")
        }
    }
    
    //fail
    func Failed(strerrormessage: String) {
        DispatchQueue.main.async {
            
            self.view.isUserInteractionEnabled = true
            
            print(strerrormessage)
            
            let alertController: UIAlertController = UIAlertController(title: "Alert", message:strerrormessage, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
}

