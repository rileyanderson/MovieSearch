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
    
    var images:Array<String> = Array<String>()

    
    var search:SearchResults = SearchResults()
    
    func loadData(movie:Movie)
    {
        
        let URL = NSURL(string: movie.background)
        background.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))

        
        let URLPoster = NSURL(string: movie.poster)
        poster.sd_setImageWithURL(URLPoster, placeholderImage: UIImage(named: "placeholder.png"))
        
        rating.text =  "\u{2B50} \(movie.rating) / 10"
        
        search.getMoreData(movie){responseObject in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.genre.text = responseObject.genre
                self.runningTime.text = "\(responseObject.runtime) min"
                self.mpaa.text = "\(responseObject.mpaa) |"
                self.images = responseObject.images
                
                //var link = responseObject.trailer
                self.trailer.allowsInlineMediaPlayback = true
                self.trailer.loadHTMLString("<iframe width=\"\(self.trailer.frame.width - 15)\" height=\"\(self.trailer.frame.height)\" src=\"\(responseObject.trailerLink)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
                
            })
        
        }
        
    }
    
    func loadTitle(movie:Movie)
    {
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
        title.text = "\(movie.title) (\(movieYear!))"
        
        desc.text = movie.description
        desc.sizeToFit()
        title.sizeToFit()
    }
    

    

}