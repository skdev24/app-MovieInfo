//
//  MovieDetailVC.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImageView2: UIImageView!
    @IBOutlet weak var moviewGenre: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var activityInticator: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityInticator.isHidden = false
        activityInticator.startAnimating()
    }
    @IBAction func dismissBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
