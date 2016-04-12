//
//  Movie.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit

let apiKey = "9220f93712a0d77085967f893da01eae"

class Movie
{
    
    var title: String
    var description: String
    //var poster: String
    //var background: String
    var rating: Float
    var releaseDate: String
    var id: Int
    var poster:UIImage
    var background: UIImage
    
    init(title: String, description:String, poster:UIImage, background: UIImage, rating:Float, releaseDate: String, id:Int)
    {
        self.title = title;
        self.description = description
        self.poster = poster
        self.background = background
        self.rating = rating
        self.releaseDate = releaseDate
        self.id = id
    }
    
    
}
    
