//
//  Movie.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit


/*Movie class
 *
 *Creates a movie object with the: title, description, poster, backgrond image, rating, release date, and id
 */
class Movie
{
    
    var title: String
    var description: String
    var poster: String
    var background: String
    var rating: Float
    var releaseDate: String
    var id: Int
    
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

/*MovieExtraData class
 *
 *Creates a movieExtraData object with the: genre, runtime, mpaa, images, and trailerLink
 */
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

