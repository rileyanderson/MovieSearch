//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/11/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate,UpDatedFavoritesDelegate,buttonPressedDelegate
{
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var queryLabel: UILabel!
    @IBOutlet var search: UITextField!
    var movie: SearchResults = SearchResults()
    
    var myMovies:SearchResults?
    var arr = Array<Movie>()
    
    var favoriteSetId:Set<Int> = []
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var needToUpdateFavorites:Bool = false
    
    override func viewWillAppear(animated: Bool)
    {
        if needToUpdateFavorites == true && queryLabel.text == "Favorites"
        {
            movie.getMovieFavorites(favoriteSetId){responseObject in
                
                self.arr = responseObject
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
        
        if let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow
        {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
  

    override func viewDidLoad()
    {
        
        
        self.favoriteSetId = Set(defaults.objectForKey("Favorites") as? Array<Int> ?? Array<Int>())
        
        navigationController?.popoverPresentationController?.backgroundColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = true
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.delegate      =   self
        tableView.dataSource    =   self
        self.view.addSubview(self.tableView)
        
        search.delegate = self
        
        
        movie.getMovieData("", type: "Popular"){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
            
        }
        
        //Dismiss the keybard when tapped out of search
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MovieListViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
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
            let popOverVC = segue.destinationViewController as! PopupViewController
            popOverVC.popoverPresentationController?.delegate = self
            popOverVC.delegate = self
            dismissKeyboard()
            
            
        }
        else if(segue.identifier == "segueFromCell")
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let destinationViewController = segue.destinationViewController as! MovieDetailViewController
            destinationViewController.delegate = self
            destinationViewController.movie = arr[indexPath.row]
            destinationViewController.favoriteMovieIDSet = self.favoriteSetId
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
                self.queryLabel.text = "Search Results"
                self.tableView.reloadData()
                
            })
            
        }
        search.resignFirstResponder()
        
        return true
        
    }
    
    func newFavorites(favoriteMovieSetId: Set<Int>, deleted:Bool)
    {
        self.favoriteSetId = favoriteMovieSetId
        needToUpdateFavorites = deleted;
        let array = Array(favoriteSetId)
        defaults.setObject(array, forKey: "Favorites")
    }
    
    func popularPressed()
    {
        movie.getMovieData("", type: "Popular"){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
        }
        queryLabel.text = "Popular"
       
    }
    
    func inTheatersPressed()
    {
        movie.getMovieData("", type: "InTheatres"){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
        }
        queryLabel.text = "In Theaters"
        
    }
    
    func favoritesPressed()
    {
        
        movie.getMovieFavorites(favoriteSetId){responseObject in
            
            self.arr = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        queryLabel.text = "Favorites"
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        search.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        dismissKeyboard()
    }
    
    
    
}
