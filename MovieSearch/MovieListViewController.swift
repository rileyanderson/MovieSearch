//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    //private var searches = [SearchResults]()
    
    var movie: SearchResults = SearchResults()
    var myMovies:SearchResults?
    var arr = Array<Movie>()
    let sampleTextField = UITextField(frame: CGRectMake(0, 0, 200, 20))
    var tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
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
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        
        let movie:Movie = arr[indexPath.row]
        
        cell.textLabel!.text = movie.title
        cell.detailTextLabel!.text = movie.description
        
        //        var myImage: UIImage!
        //        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        //
        //            myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:"https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png")!)!)
        //        })
        //
        //        cell.imageView!.image = myImage
        //        var cache = ImageLoadingWithCache()
        //        var imageView:UIImageView = UIImageView()
        //        cache.getImage("https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png", imageView: imageView, defaultImage: "Poster")
        //
        //        cell.imageView!.image = imageView.image
        var posterImage:UIImage?
        var posterString:String
        if movie.poster == "nil"
        {
            posterString = "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2.png"
        }
        else
        {
            posterString = "http://image.tmdb.org/t/p/w500/\(movie.poster)"
            
        }
        
        
       // let URL = NSURL(string: posterString)
        //let imageData = NSData(contentsOfURL: URL!)
        //let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
        //dispatch_async(dispatch_get_main_queue()) {
        // self.poster = UIImage(data: imageData!)
        //}
        // }
       
               // posterImage = UIImage(data: imageData!)!
        
        
        cell.imageView!.image = movie.poster
        return cell
  
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        movie.getMovieData(sampleTextField.text!){responseObject in
            
            
            //            for a in responseObject
            //            {
            //                print(a.title)
            //            }
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
        
        
        return true
        
    }
    
}
