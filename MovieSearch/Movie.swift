//
//  Movie.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit

class Movie
{
    
    var title: String
    var description: String
    var poster: String
    var background: String
    var rating: Float
    var releaseDate: String
    var id: Int
    
    
    
    
    //var poster:UIImage
    //var background: UIImage
    
    init(title: String, description:String, poster:String, background: String, rating:Float, releaseDate: String, id:Int)
    {
        self.title = title
        self.description = description
        self.poster = poster
        self.background = background
        self.rating = rating
        self.releaseDate = releaseDate
        self.id = id
    }
    
    
}

class MovieExtraData
{
    var genre:String
    var runtime:Int
    var mpaa:String
    var images:Array<String>
    var trailerLink:String
    
    init(genre: String, runtime:Int, mpaa:String, images: Array<String>, trailerLink:String)
    {
        self.genre = genre;
        self.runtime = runtime
        self.mpaa = mpaa
        self.images = images
        self.trailerLink = trailerLink
    }
    
    
}

