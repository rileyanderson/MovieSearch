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
    
    var search:SearchResults = SearchResults()
    
    func loadData(movie:Movie)
    {
        let URL = NSURL(string: movie.background)
        background.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        
        let URLPoster = NSURL(string: movie.poster)
        poster.sd_setImageWithURL(URLPoster, placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        rating.text =  "\u{2B50} \(movie.rating) / 10"

        //print(movieYear)
        
        
        //search.getMoreData(movie, callback: <#T##(Array<String>) -> ()#>)
        search.getMoreData(movie){responseObject in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
            
            self.genre.text = responseObject[0]
            self.runningTime.text = "\(responseObject[1]) min"
            self.mpaa.text = "\(responseObject[2]) |"
     })

            
        }
        
    }
    
    func loadTitle(movie:Movie)
    {
        let index = movie.releaseDate.rangeOfString("-", options: .BackwardsSearch)?.startIndex
        let movieYearDay = movie.releaseDate.substringToIndex(index!)
        
        let index2 = movieYearDay.rangeOfString("-", options: .BackwardsSearch)?.startIndex
        let movieYear = movieYearDay.substringToIndex(index2!)
        title.text = "\(movie.title) (\(movieYear))"
        
        desc.text = movie.description
        desc.sizeToFit()
        title.sizeToFit()
    }
}
