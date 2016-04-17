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
    var resultingMovies = Array<Movie>()
    var favoriteSetId:Set<Int> = []
    let defaults = NSUserDefaults.standardUserDefaults()
    var needToUpdateFavorites:Bool = false
    
    override func viewWillAppear(animated: Bool)
    {
        //Check if a favorite movie was deleted and the previos table view was "Favorites" If it is, update the view
        if needToUpdateFavorites == true && queryLabel.text == "Favorites"
        {
            movie.getMovieFavorites(favoriteSetId){responseObject in
                
                self.resultingMovies = responseObject
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
        
        //Remove highlighted cell upon return
        if let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow
        {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    
    override func viewDidLoad()
    {
        
        //Get the device saved favorites set
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
        
        //Default load the "Popular Movies"
        movie.getMainMovieData("", type: "Popular"){responseObject in
            self.resultingMovies = responseObject
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
        return resultingMovies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        let movie:Movie = resultingMovies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! TableCell
        cell.updateCell(movie)
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        //show the popOver menu
        if(segue.identifier == "showMenu")
        {
            let popOverVC = segue.destinationViewController as! PopupViewController
            popOverVC.popoverPresentationController?.delegate = self
            popOverVC.delegate = self
            dismissKeyboard()
            
            
        }
            //Segue to the movie detail view from the selected cell
        else if(segue.identifier == "segueFromCell")
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let destinationViewController = segue.destinationViewController as! MovieDetailViewController
            destinationViewController.delegate = self
            destinationViewController.movie = resultingMovies[indexPath.row]
            destinationViewController.favoriteMovieIDSet = self.favoriteSetId
        }
        
        
    }
    
    //Setup the popoverMenu
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    //Search for the movie when "Search" is pressed on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        movie.getMainMovieData(search.text!, type: "Search"){responseObject in
            
            self.resultingMovies = responseObject
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.queryLabel.text = "Search Results"
                self.tableView.reloadData()
                
            })
            
        }
        search.resignFirstResponder()
        
        return true
        
    }
    
    //Delegate to update favorites list, also save it to the device
    func newFavorites(favoriteMovieSetId: Set<Int>, deleted:Bool)
    {
        self.favoriteSetId = favoriteMovieSetId
        needToUpdateFavorites = deleted;
        let array = Array(favoriteSetId)
        defaults.setObject(array, forKey: "Favorites")
    }
    
    //Delegate that popular was pressed in the popover menu
    func popularPressed()
    {
        movie.getMainMovieData("", type: "Popular"){responseObject in
            
            self.resultingMovies = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
        }
        queryLabel.text = "Popular"
        
    }
    
    //Delegate that intheaters was pressed in the popover menu
    func inTheatersPressed()
    {
        movie.getMainMovieData("", type: "InTheatres"){responseObject in
            
            self.resultingMovies = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
        }
        queryLabel.text = "In Theaters"
        
    }
    
    //Delegate that favorites was pressed in the popover menu
    func favoritesPressed()
    {
        
        movie.getMovieFavorites(favoriteSetId){responseObject in
            
            self.resultingMovies = responseObject
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        queryLabel.text = "Favorites"
        
    }
    
    //Hide the keyboard when not in use
    func dismissKeyboard()
    {
        search.resignFirstResponder()
    }
    //Hide keyboard when scrolling
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        dismissKeyboard()
    }
    
    
    
}
