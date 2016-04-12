//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, ResultsToMovieListViewControllerDelegate
{
    //private var searches = [SearchResults]()
    
    var movie: SearchResults = SearchResults()
    var myMovies:SearchResults?
    var arr = Array<Movie>()
    override func viewDidLoad()
    {
        movie.getMovieData(){responseObject in
            

        for a in responseObject
        {
            print(a.title)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        }
        
        
        
//        myMovies = SearchResults()
//        myMovies!.delegate = self
//        self.myMovies!.delegate = self
        
        
        
        
        
      
        
    }
    
    func resultsUpdated(movieModel:Movie)
    {
        
    }
    
    
    
}
