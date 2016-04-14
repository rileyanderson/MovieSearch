//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/13/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation

import UIKit

class MovieDetailViewController : UIViewController
{
    @IBOutlet var movieDetailView: MovieDetailView!
    
    var movie: Movie!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        movieDetailView.loadData(movie)
        
    }
    
    override func viewDidLayoutSubviews()
    {
       movieDetailView.loadTitle(movie)
    }
}