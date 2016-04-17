//
//  TableCell.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/12/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell
{
    @IBOutlet var userRating: UILabel!
    @IBOutlet var title: UILabel!
    var placehalder:String?
    @IBOutlet var year: UILabel!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var desc: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    
    func updateCell(movie:Movie)
    {
        showActivityIndicator()
        title.text = movie.title
        desc.text = movie.description
        userRating.text =  "\u{2B50} \(movie.rating) / 10"
        
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
        
        //print(movieYear)
        year.text = "(\(movieYear!))"
        
        let URL = NSURL(string: movie.poster)
        
        poster.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        hideActivityIndicator()
    }
    
    func showActivityIndicator()
    {
        UIView.animateWithDuration( 0.7, animations: {
            self.loadingView.alpha = 1.0
        })
    }
    
    func hideActivityIndicator()
    {
        UIView.animateWithDuration( 0.7, animations: {
            self.loadingView.alpha = 0.0
        })
    }
    
    
    
}
