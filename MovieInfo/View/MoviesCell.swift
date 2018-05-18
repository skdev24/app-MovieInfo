//
//  MoviesCell.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    

    func update(name: String) {
        movieNameLbl.text = name
    }
    @IBAction func favBtnWasPressed(_ sender: UIButton) {
        
    }
    
}
