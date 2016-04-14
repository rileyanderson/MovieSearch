//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/13/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation

import UIKit

class MovieDetailViewController : UIViewController, UICollectionViewDataSource
{
    @IBOutlet var movieDetailView: MovieDetailView!
    
    @IBOutlet var extraImagesCollectionView: UICollectionView!
    var movie: Movie!
    var search:SearchResults = SearchResults()
    var images:Array<String> = Array<String>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        search.getMoreData(movie){responseObject in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.images = responseObject.images
                self.movieDetailView.loadData(self.movie)
                self.extraImagesCollectionView.reloadData()
                
            })
        }
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

    
    
    
}