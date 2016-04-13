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
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        
        let URL = NSURL(string: movie.poster)
        
        let title:String = movie.title
        let desc:String = movie.description
        
        cell.imageView!.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = desc
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.tableView.reloadData()
//        })
        
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
