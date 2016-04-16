//
//  PopupViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/15/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

protocol buttonPressedDelegate
{
    func popularPressed()
    func inTheatersPressed()
    func favoritesPressed()
}

class PopupViewController: UIViewController
{
    
    @IBOutlet var popular: UIButton!
    @IBOutlet var inTheaters: UIButton!
    @IBOutlet var favorites: UIButton!
    var delegate: buttonPressedDelegate! = nil
    
    override func viewDidLoad()
    {
 
        popular.addTarget(self, action: #selector(PopupViewController.PopularPressed), forControlEvents: .TouchUpInside)
        favorites.addTarget(self, action: #selector(PopupViewController.FavoritesPressed), forControlEvents: .TouchUpInside)
        inTheaters.addTarget(self, action: #selector(PopupViewController.InTheatersPressed), forControlEvents: .TouchUpInside)
        
    }
    
    
    func PopularPressed()
    {
        delegate.popularPressed()
        self.dismissViewControllerAnimated(true, completion: nil)
        popular.backgroundColor = UIColor.grayColor()
        
    }
    
    func FavoritesPressed()
    {
        
        delegate.favoritesPressed()
        self.dismissViewControllerAnimated(true, completion: nil)
        favorites.backgroundColor = UIColor.grayColor()
    }
    
    func InTheatersPressed()
    {
        delegate.inTheatersPressed()
        self.dismissViewControllerAnimated(true, completion: nil)
        inTheaters.backgroundColor = UIColor.grayColor()
    }
    

    
    
    
    
}
