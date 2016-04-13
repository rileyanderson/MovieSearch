//
//  TableCell.swift
//  MovieSearch
//
//  Created by Riley Anderson on 4/12/16.
//  Copyright © 2016 Riley Anderson. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell
{
    @IBOutlet var title: UILabel!
    var placehalder:String?
    @IBOutlet var poster: UIImageView!
    @IBOutlet var desc: UILabel!
    
    
    func updateCell(movie:Movie)
    {
        title.text = movie.title
        desc.text = movie.description
        
        let URL = NSURL(string: movie.poster)

        poster.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
    
}
