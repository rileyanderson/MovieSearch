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
    
    let apiKey:String = "9220f93712a0d77085967f893da01eae"
    
    var title: String?
    var description: String?
    var posterURL:  String?
    var backdropURL: String?
    var id:  Int?
    var rating:  Float?
    var date: String?
    var poster:UIImage?
    var backdrop:UIImage?
    
    var genre:String?
    var runtime:Int?
    var mpaa:String?
    var images:Array<String>?
    var trailer:String?
    
    //Now Playing
    //https://api.themoviedb.org/3/movie/now_playing?api_key=9220f93712a0d77085967f893da01eae
    
    //popular
    //https://api.themoviedb.org/3/movie/popular?api_key=9220f93712a0d77085967f893da01eae
    
    
    func getMovieData(search: String, type:String, callback:(Array<Movie>) -> ())
    {
        let searchSpaceFree:String = search.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        var query = ""
        if(type == "Search")
        {
            query = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchSpaceFree)"
        }
        else if(type == "InTheatres")
        {
            query = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        }
        else if(type == "Popular")
        {
            query = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        }
        else if(type == "Favorites")
        {
            query = "https://api.themoviedb.org/3/movie/\(search)?api_key=\(apiKey)"
            
        }
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: query)!
        var callBackArray  = Array<Movie>()
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else
            {
                print("Not a 200 response")
                return
            }
            
            // Read the JSON
            do {
                if let _ = NSString(data:data!, encoding: NSUTF8StringEncoding)
                {
                    
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
                        
                        //http://image.tmdb.org/t/p/w500/tsKF46QfepjVQSkvtYGPn7IICTC.jpg
                        var backDropPath:String
                        if self.backdropURL == "nil"
                        {
                            backDropPath = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
                        }
                        else
                        {
                            backDropPath = "http://image.tmdb.org/t/p/w500/\(self.backdropURL!)"
                            
                        }
                        
                        let newMovie: Movie = Movie(title: self.title!, description: self.description!, poster: posterString, background: backDropPath, rating: self.rating!, releaseDate: self.date!, id: self.id!)
                      
                        
                        callBackArray.append(newMovie);
                        
                    }
                }
                callback(callBackArray)
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    
    
    ///////////////////////////////////////
    
    func getMoreData(search: Movie, callback:(MovieExtraData) -> ())
    {
        
        let postEndpoint: String = "https://api.themoviedb.org/3/movie/\(search.id)?api_key=\(apiKey)&append_to_response=releases,trailers,images"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        self.images = Array<String>()
        var movieExtras:MovieExtraData?
        self.genre = ""
        var trailerArray: Array<String> = Array<String>()
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else
            {
                print("Not a 200 response")
                return
            }
            
            // Read the JSON
            do {
                if let _ = NSString(data:data!, encoding: NSUTF8StringEncoding)
                {
                    
                    // Parse the JSON
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    //Get the genres
                    for d in jsonDictionary["genres"] as! [Dictionary<String, AnyObject>]
                    {
                        
                        self.genre! += "|\( d["name"] as? String ?? "nil")"
                        
                    }
                    //Runtime
                    self.runtime = jsonDictionary["runtime"] as? Int ?? -1
                    
                    self.genre! += "|";
                    
                    //Get MPAA
                    let releasesDictionary = jsonDictionary["releases"] as! Dictionary<String, AnyObject>
                    
                    for c in releasesDictionary["countries"] as! [Dictionary<String, AnyObject>]
                    {
                        if c["iso_3166_1"] as? String == "US"
                        {
                            self.mpaa = c["certification"] as? String ?? "unrated"
                            
                        }
                        
                    }
                    
                    //Get images
                    let imagesDictionary = jsonDictionary["images"] as! Dictionary<String, AnyObject>
                    
                    for b in imagesDictionary["backdrops"] as! [Dictionary<String, AnyObject>]
                    {
                        
                        var imageString:String = ""
                        
                        if b["file_path"] as? String ?? "nil" == "nil"
                        {
                            imageString = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
                        }
                        else
                        {
                            imageString = "http://image.tmdb.org/t/p/w500/\(b["file_path"] as! String)"
                            
                        }
                        
                        self.images?.append(imageString)
                        
                        
                    }
                    
                    //Get trailer
                    let trailerDictionary = jsonDictionary["trailers"] as! Dictionary<String, AnyObject>
    
                    for y in trailerDictionary["youtube"] as! [Dictionary<String, AnyObject>]
                    {
                        trailerArray.append(y["source"] as? String ?? "none")
                        
                    }
                    
                    if(trailerArray.count == 0)
                    {
                        trailerArray.append("none")
                    }
                    
                    self.trailer = "https://www.youtube.com/embed/\(trailerArray[0])"
          
                    //Account for empty api returns
                    if(self.images?.count == 0)
                    {
                        self.images?.append("https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png")
                    }
                    
                    if self.mpaa == nil
                    {
                        self.mpaa = "Unr."
                    }
                    
                    movieExtras = MovieExtraData(genre: self.genre!, runtime: self.runtime!, mpaa: self.mpaa!, images: self.images!, trailerLink:self.trailer!)
                    
                    
                }
                callback(movieExtras!)
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    
    
    func getMovieFavorites(favorites:Set<Int>,  callback:(Array<Movie>) -> ())
    {
        var callBackArray  = Array<Movie>()
        for fav in favorites
        {
            let query = "https://api.themoviedb.org/3/movie/\(fav)?api_key=\(apiKey)"
            let session = NSURLSession.sharedSession()
            let url = NSURL(string: query)!

            // Make the POST call and handle it in a completion handler
            session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                // Make sure we get an OK response
                guard let realResponse = response as? NSHTTPURLResponse where
                    realResponse.statusCode == 200 else
                {
                    print("Not a 200 response")
                    return
                }
                
                // Read the JSON
                do {
                    if let _ = NSString(data:data!, encoding: NSUTF8StringEncoding)
                    {
                        
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        
                        // print(d)
                        self.title = jsonDictionary["original_title"] as? String ?? "nil"
                        self.description = jsonDictionary["overview"] as? String ?? "nil"
                        self.posterURL = jsonDictionary["poster_path"] as? String ?? "nil"
                        self.backdropURL = jsonDictionary["backdrop_path"] as? String ?? "nil"
                        self.id = jsonDictionary["id"] as? Int ?? -1
                        self.rating = jsonDictionary["vote_average"] as? Float ?? -1
                        self.date = jsonDictionary["release_date"] as? String ?? "nil"
                        
                        var posterString:String
                        if self.posterURL == "nil"
                        {
                            posterString = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
                        }
                        else
                        {
                            posterString = "http://image.tmdb.org/t/p/w500/\(self.posterURL!)"
                            
                        }
                        
                        //http://image.tmdb.org/t/p/w500/tsKF46QfepjVQSkvtYGPn7IICTC.jpg
                        var backDropPath:String
                        if self.backdropURL == "nil"
                        {
                            backDropPath = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
                        }
                        else
                        {
                            backDropPath = "http://image.tmdb.org/t/p/w500/\(self.backdropURL!)"
                            
                        }
                        
                        let newMovie: Movie = Movie(title: self.title!, description: self.description!, poster: posterString, background: backDropPath, rating: self.rating!, releaseDate: self.date!, id: self.id!)
                        
                        callBackArray.append(newMovie);
                        
                        
                    }
                    callback(callBackArray)
                } catch {
                    print("bad things happened")
                }
            }).resume()
        }
        callback(callBackArray)
        
    }
    
    
    
    
    
    
    
    
    
}
