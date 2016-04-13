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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var search: UITextField!
    var movie: SearchResults = SearchResults()
    
    var myMovies:SearchResults?
    var arr = Array<Movie>()

    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.delegate      =   self
        tableView.dataSource    =   self
        self.view.addSubview(self.tableView)

        search.delegate = self
        //navigationItem.titleView = sampleTextField
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        
        let movie:Movie = arr[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! TableCell
        cell.updateCell(movie)
        return cell
  
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        movie.getMovieData(search.text!){responseObject in

            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
        
        
        return true
        
    }
    
}
