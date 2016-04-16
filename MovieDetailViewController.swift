//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/13/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation

import UIKit

protocol UpDatedFavoritesDelegate
{
    func newFavorites(favoriteArrayId:Set<Int>, deleted:Bool)
}

class MovieDetailViewController : UIViewController, UICollectionViewDataSource
{
    @IBOutlet var movieDetailView: MovieDetailView!
    @IBOutlet var extraImagesCollectionView: UICollectionView!
    var movie: Movie!
    var search:SearchResults = SearchResults()
    var images:Array<String> = Array<String>()
    
    var delegate : UpDatedFavoritesDelegate! = nil
    
    var favoriteMovieIDSet:Set<Int>! = nil
    
    var isFavoriteMovie:Bool?
    //In button action
    let button = UIButton()
    var wasDeleted:Bool = false
    
    override func viewWillAppear(animated: Bool)
    {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = true
        
        
        button.frame = CGRectMake(0, 0, 51, 31)
        
        //Ceck If Movie is favorite
        if(favoriteMovieIDSet.contains(movie.id))
        {
            isFavoriteMovie = true
            button.setImage(UIImage(named: "favoriteYes.png"), forState: .Normal)
        }
        else
        {
            isFavoriteMovie = false
            button.setImage(UIImage(named: "favorite.png"), forState: .Normal)
        }
        
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
        button.addTarget(self, action: #selector(MovieDetailViewController.favoriteButton), forControlEvents: .TouchUpInside)
        
        search.getMoreData(movie){responseObject in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.images = responseObject.images
                self.movieDetailView.loadData(self.movie)
                self.extraImagesCollectionView.reloadData()
                
            })
        }
        
        delegate.newFavorites(favoriteMovieIDSet, deleted: wasDeleted)
        
    }
    
    override func viewDidLayoutSubviews()
    {
        movieDetailView.loadTitle(movie)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ExtraImageCell
        
        let URL = NSURL(string: self.images[indexPath.item])
        cell.extraImage.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }
    
    func favoriteButton()
    {
        if favoriteMovieIDSet.contains(movie.id)
        {
            favoriteMovieIDSet.remove(movie.id)
            isFavoriteMovie = false
            wasDeleted = true
        }
        
        else
        {
            favoriteMovieIDSet.insert(movie.id)
            isFavoriteMovie = true
            wasDeleted = false
        }
        
        self.viewDidLoad()
    }
    
    
}