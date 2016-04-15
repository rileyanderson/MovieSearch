//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate
{
    @IBOutlet var tableView: UITableView!

    //@IBOutlet var search: UITextField!
    @IBOutlet var search: UITextField!
    var movie: SearchResults = SearchResults()
    
        var myMovies:SearchResults?
    var arr = Array<Movie>()
    
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        navigationController?.popoverPresentationController?.backgroundColor = UIColor.blackColor()
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        
        navigationController?.popoverPresentationController?.backgroundColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = true
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.delegate      =   self
        tableView.dataSource    =   self
        self.view.addSubview(self.tableView)
        
        search.delegate = self
        
        
        movie.getMovieData(search.text!, type: "Popular"){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
            
        }
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "showMenu")
        {
            let popOverVC = segue.destinationViewController
            popOverVC.popoverPresentationController?.delegate = self
            
        }
        else
        {
            
            
            var cellIndex:Int?
            //let letCell = sender as! TableCell
            cellIndex = tableView.indexPathForSelectedRow!.row
            
            let destinationViewController = segue.destinationViewController as! MovieDetailViewController
            destinationViewController.movie = arr[cellIndex!]
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        movie.getMovieData(search.text!, type: "Search"){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
            
        }
        
        
        return true
        
    }
    
}
