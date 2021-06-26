//
//  MovieClsCell.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class MovieClsCell: UICollectionViewCell {
    
    //MARK: outlets ---------------------------------------------------------

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var viewOverlay: UIView!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        self.layoutIfNeeded()
        imgCover.setCorner()
        viewOverlay.setCorner()
    }
    
    //MARK: others ---------------------------------------------------------
    
    func setupData(_ movie : Movie){
        imgCover.imageFromUrl(urlString: backdropUrl + (movie.backdrop_path ?? ""))

    }
    
}
