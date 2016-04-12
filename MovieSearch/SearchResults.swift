//
//  SearchResults.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit

protocol ResultsToMovieListViewControllerDelegate: class
{
    func resultsUpdated(movieModel: Movie)
}

class SearchResults{
    
    var _results:[Movie] = []
    
    var results:[Movie]{
        get{return _results}
    }
    
    
    
    weak var delegate: ResultsToMovieListViewControllerDelegate? = nil
   
    init()
    {
        
    }
    
//    func getMovieData(search: String,completionHandler: (NSArray?, NSError?) -> ())
//    {
//        call(search, completionHandler: completionHandler)
//    }
    
    //https://api.themoviedb.org/3/search/movie?api_key=9220f93712a0d77085967f893da01eae&query=fight
    func getMovieData(callback:(Array<Movie>) -> ())
    {
        let postEndpoint: String = "https://api.themoviedb.org/3/search/movie?api_key=9220f93712a0d77085967f893da01eae&query=Batman"
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
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    //print(ipString)
                    
                    // Parse the JSON to get the IP
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    for d in jsonDictionary["results"] as! [Dictionary<String, AnyObject>]
                    {
                        let title = d["original_title"] as! String
                        let description = d["overview"] as! String
                        let poster = d["poster_path"] as! String
                        let backdrop = d["backdrop_path"] as! String
                        let id = d["id"] as! Int
                        let rating = d["vote_average"] as! Float
                        let date = d["release_date"] as! String
                        
                        var newMovie: Movie = Movie(title: title, description: description, poster: poster, background: backdrop, rating: rating, releaseDate: date, id: id)
//                        self.newMovie.title = title;
//                        self.newMovie.description = description;
//                        self.newMovie.poster = poster
//                        self.newMovie.background = backdrop
//                        self.newMovie.id = id
//                        self.newMovie.rating = rating
//                        self.newMovie.releaseDate = date;
                        
                        callBackArray.append(newMovie);
                        
                    }
                    // Update the label
                    // self.performSelectorOnMainThread("updateIPLabel:", withObject: origin, waitUntilDone: false)
                }
                callback(callBackArray)
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    
    
    
 
}
