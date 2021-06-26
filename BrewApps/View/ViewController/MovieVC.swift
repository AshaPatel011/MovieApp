//
//  MovieVC.swift
//  BrewApps
//
//  Created by Asha on 25/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {
    
    //MARK: outlets ---------------------------------------------------------
    
    @IBOutlet weak var clsMovie: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblNodata: UILabel!
    
    //MARK: properties ---------------------------------------------------------
    
    var movieHelper_Parser = MovieHelper_Parser()
    var arrMovie : [Movie]?
    
    //MARK: view controller life cycle ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMoviewList()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.setCorner()
    }
    
    //MARK: API calling ---------------------------------------------------------
    
    func getMoviewList()
    {
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
        
        movieHelper_Parser.initWith(helperDelegate: self)
        movieHelper_Parser.getMovieList(viewController: self)
    }
    
    //MARK: Others ---------------------------------------------------------
    
    @objc func btnDeleteTapped(_ sender : UIButton){
        
        let hitPoint = sender.convert(CGPoint.zero, to: clsMovie)
        let hitIndex: IndexPath? = clsMovie.indexPathForItem(at: hitPoint)
        
        if let index = hitIndex{
            movieHelper_Parser.getMovieDelete(index)
        }
    }
    
    func noDataFound(){
        lblNodata.isHidden = arrMovie?.count ?? 0 == 0 ? false : true
    }
}

//MARK: collectionView Delegate ---------------------------------------------------------

extension MovieVC : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMovie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieClsCell", for: indexPath) as! MovieClsCell
        let cellPoster = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterClsCell", for: indexPath) as! MoviePosterClsCell
        
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
        cellPoster.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
        
        cellPoster.btnDelete.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        if let obj = arrMovie?[indexPath.row]{
            cell.setupData(obj)
            cellPoster.setupData(obj)
            return obj.vote_average ?? 0 > 7 ? cell : cellPoster
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let obj = arrMovie?[indexPath.row]{
            return obj.vote_average ?? 0 > 7 ?  CGSize(width:collectionView.frame.width, height: 230) : CGSize(width:collectionView.frame.width, height: 280)
        }
        
        return CGSize(width:collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.dictMovie = arrMovie?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: searchBar Delegate ---------------------------------------------------------

extension MovieVC : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieHelper_Parser.getMovieSearch(searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieHelper_Parser.getMovieSearch(searchText)
    }
    
}

//MARK: movieHelper Delegate ---------------------------------------------------------

extension MovieVC : MovieHelperParserDelegate{
    
    //Delete
    func Delete(arrMovie: [Movie],index: IndexPath) {
        self.arrMovie = arrMovie
        
        self.clsMovie.performBatchUpdates({
            self.clsMovie.deleteItems(at: [index])
        }) { (finished) in
            self.clsMovie.reloadItems(at: self.clsMovie.indexPathsForVisibleItems)
        }
        
        self.noDataFound()
        
    }
    
    //search
    func Search(arrMovie: [Movie]) {
        self.arrMovie = arrMovie
        self.clsMovie.reloadData()
        self.noDataFound()

    }
    
    
    //success
    func Success(arrMovie: [Movie]) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.arrMovie = arrMovie
            self.clsMovie.reloadData()
            self.noDataFound()
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


