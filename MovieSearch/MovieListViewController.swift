//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITextFieldDelegate
{
    //private var searches = [SearchResults]()
    
    var movie: SearchResults = SearchResults()
    var myMovies:SearchResults?
    var arr = Array<Movie>()
     let sampleTextField = UITextField(frame: CGRectMake(0, 0, 200, 20))

    override func viewDidLoad()
    {
        
       
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFontOfSize(15)
        sampleTextField.borderStyle = UITextBorderStyle.RoundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.Default
        sampleTextField.returnKeyType = UIReturnKeyType.Search
        sampleTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sampleTextField.delegate = self
        navigationItem.titleView = sampleTextField
        self.view.backgroundColor = UIColor.whiteColor()
     
            
           
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        }
        
        
        
//        myMovies = SearchResults()
//        myMovies!.delegate = self
//        self.myMovies!.delegate = self
        
        
        
        
        
      
        
    

func textFieldShouldReturn(textField: UITextField) -> Bool
{
    movie.getMovieData(sampleTextField.text!){responseObject in
        
        
        for a in responseObject
        {
            print(a.title)
        }
        
    }
    
  return true
    
    }
    
}
