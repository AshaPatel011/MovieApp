//
//  MoviePosterClsCell.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class MoviePosterClsCell: UICollectionViewCell {
    
    //MARK: outlets ---------------------------------------------------------

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var viewOverlay: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        self.layoutIfNeeded()
        imgCover.setCorner()
        viewOverlay.setCorner()

    }
    
    //MARK: others ---------------------------------------------------------
    
    func setupData(_ movie : Movie){
        lblTitle.text = movie.title
        lblDesc.text = movie.overview
        imgCover.imageFromUrl(urlString: posterUrl + (movie.poster_path ?? ""))

    }
    
}
