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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var movieDetailView: MovieDetailView!
    @IBOutlet var extraImagesCollectionView: UICollectionView!

    
    var delegate : UpDatedFavoritesDelegate! = nil
    var movie: Movie!
    var search:SearchResults = SearchResults()
    var images:Array<String> = Array<String>()
    var favoriteMovieIDSet:Set<Int>! = nil
    var isFavoriteMovie:Bool?
    let button = UIButton()
    var wasDeleted:Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        showActivityIndicator()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = true
        
        
        //Set up the heart button
        button.frame = CGRectMake(0, 0, 51, 31)
        
        //Ceck If Movie is favorite and set heart button accordingly
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
        
        //Set button to in the navigation bar
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
        button.addTarget(self, action: #selector(MovieDetailViewController.favoriteButton), forControlEvents: .TouchUpInside)
        navigationController?.navigationBar.tintColor = UIColor.grayColor()
        
        //Set up the views
        search.getMoreDataForDetail(movie){responseObject in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.images = responseObject.images
                self.movieDetailView.loadData(self.movie,extraData:responseObject)
                self.extraImagesCollectionView.reloadData()
                
                
            })
            self.hideActivityIndicator()
        }
        
        
        sendDelegate()
        
    }
    
    //Set up the extra images collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ExtraImageCell
        
        let URL = NSURL(string: self.images[indexPath.item])
        cell.extraImage.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }
    
    //Change the state and add or delete from user favorits
    func favoriteButton()
    {
        if favoriteMovieIDSet.contains(movie.id)
        {
            favoriteMovieIDSet.remove(movie.id)
            isFavoriteMovie = false
            wasDeleted = true
            button.setImage(UIImage(named: "favorite.png"), forState: .Normal)
        }
            
        else
        {
            favoriteMovieIDSet.insert(movie.id)
            isFavoriteMovie = true
            wasDeleted = false
            button.setImage(UIImage(named: "favoriteYes.png"), forState: .Normal)
        }
        sendDelegate()
    }
    
    
    //Send the resulting favorite informaton
    func sendDelegate()
    {
        delegate.newFavorites(favoriteMovieIDSet, deleted: wasDeleted)
    }
    
    func showActivityIndicator()
    {
        activityIndicator.startAnimating()
        UIView.animateWithDuration( 0.7, animations: {
            self.loadingView.alpha = 1.0
        })
    }
    
    func hideActivityIndicator()
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIView.animateWithDuration(0.7, animations: {
                self.loadingView.alpha = 0.0
                }, completion: { finished in
                    self.activityIndicator.stopAnimating()
            })
            
        })
    }
    
    
}