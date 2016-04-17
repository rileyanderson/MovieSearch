//
//  MovieDetailView.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/13/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit
import Foundation

class MovieDetailView: UIView
{
    @IBOutlet var background: UIImageView!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var mpaa: UILabel!
    @IBOutlet var runningTime: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var trailer: UIWebView!
    //@IBOutlet var loadingView: UIView!
    //@IBOutlet var activityIndicator: UIActivityIndicatorView!
    var images:Array<String> = Array<String>()
    var search:SearchResults = SearchResults()
    
    
    
    func loadData(movie:Movie, extraData:MovieExtraData)
    {
        //showActivityIndicator()
        
        //Set the background Image
        let URL = NSURL(string: movie.background)
        background.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        
        //Set the poster image
        let URLPoster = NSURL(string: movie.poster)
        poster.sd_setImageWithURL(URLPoster, placeholderImage: UIImage(named: "placeholder.png"))
        
        //Set the user rating
        rating.text =  "\u{2B50} \(movie.rating) / 10"
        
        //Get the year from the date string
        var movieYear:String?
        if(movie.releaseDate == "")
        {
            movieYear = "-"
        }
        else
        {
            let index = movie.releaseDate.rangeOfString("-", options: .BackwardsSearch)?.startIndex
            let movieYearDay = movie.releaseDate.substringToIndex(index!)
            
            let index2 = movieYearDay.rangeOfString("-", options: .BackwardsSearch)?.startIndex
            movieYear = movieYearDay.substringToIndex(index2!)
        }
        
        //Set the title
        title.text = "\(movie.title) (\(movieYear!))"
        
        //Set the description
        desc.text = movie.description
        
        title.sizeToFit()
        
        //Set up the views
        //self.activityIndicator.startAnimating()
        self.genre.text = extraData.genre
        self.runningTime.text = "\(extraData.runtime) min"
        self.mpaa.text = "\(extraData.mpaa) |"
        self.images = extraData.images
        
        //Set up the embedded youtube link for the trailer
        self.trailer.allowsInlineMediaPlayback = true
        self.trailer.loadHTMLString("<iframe width=\"\(self.trailer.frame.width - 20)\" height=\"\(self.trailer.frame.height)\" src=\"\(extraData.trailerLink)?&playsinline=1\"></iframe>", baseURL: nil)
        self.trailer.scrollView.scrollEnabled = false
        self.trailer.opaque = false
        self.trailer.backgroundColor = UIColor.clearColor()
        
        //hideActivityIndicator()
    }
    
    //Fade in and out of view with an activity indicator for smoother loads
//    func showActivityIndicator()
//    {
//        
//        UIView.animateWithDuration( 0.7, animations: {
//            self.loadingView.alpha = 1.0
//        })
//    }
//    
//    func hideActivityIndicator()
//    {
//        
//        UIView.animateWithDuration(0.7, animations: {
//            self.loadingView.alpha = 0.0
//        })
//        //self.activityIndicator.alpha = 0.0
//    }
    
    
    
    
    
    
}
