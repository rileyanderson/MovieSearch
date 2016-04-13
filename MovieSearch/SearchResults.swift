//
//  SearchResults.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit


class SearchResults{
    
    var title: String?
    var description: String?
    var posterURL:  String?
    var backdropURL: String?
    var id:  Int?
    var rating:  Float?
    var date: String?
    var poster:UIImage?
    var backdrop:UIImage?
    
    let apiKey:String = "9220f93712a0d77085967f893da01eae"
    
    func getMovieData(search: String, callback:(Array<Movie>) -> ())
    {
        let postEndpoint: String = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(search)"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        var callBackArray  = Array<Movie>()
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let _ = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    
                    // Parse the JSON
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    for d in jsonDictionary["results"] as! [Dictionary<String, AnyObject>]
                    {
                        self.title = d["original_title"] as? String ?? "nil"
                        self.description = d["overview"] as? String ?? "nil"
                        self.posterURL = d["poster_path"] as? String ?? "nil"
                        self.backdropURL = d["backdrop_path"] as? String ?? "nil"
                        self.id = d["id"] as? Int ?? -1
                        self.rating = d["vote_average"] as? Float ?? -1
                        self.date = d["release_date"] as? String ?? "nil"
                        
                        var posterString:String
                        if self.posterURL == "nil"
                        {
                            posterString = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
                        }
                        else
                        {
                            posterString = "http://image.tmdb.org/t/p/w500/\(self.posterURL!)"
                            
                        }
                        
                    
                        let newMovie: Movie = Movie(title: self.title!, description: self.description!, poster: posterString, background: posterString, rating: self.rating!, releaseDate: self.date!, id: self.id!)
                        
                        
                        callBackArray.append(newMovie);
                        
                    }
                }
                callback(callBackArray)
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    
    
    
    
}
