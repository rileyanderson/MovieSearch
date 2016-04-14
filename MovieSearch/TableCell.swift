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
    
    
    func updateCell(movie:Movie)
    {
        title.text = movie.title
        desc.text = movie.description
        userRating.text =  "\u{2B50} \(movie.rating) / 10"
        let index = movie.releaseDate.rangeOfString("-", options: .BackwardsSearch)?.startIndex
        let movieYearDay = movie.releaseDate.substringToIndex(index!)
        
        let index2 = movieYearDay.rangeOfString("-", options: .BackwardsSearch)?.startIndex
        let movieYear = movieYearDay.substringToIndex(index2!)
        
        
        //print(movieYear)
        year.text = "(\(movieYear))"

        let URL = NSURL(string: movie.poster)

        poster.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
    
}
