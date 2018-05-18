//
//  BounceButton.swift
//  MovieInfo
//
//  Created by Shivam Dev on 17/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class BounceButton: UIButton {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addTarget(self, action: #selector(bounce), for: .touchUpInside)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                self.addTarget(self, action: #selector(bounce), for: .touchUpInside)

        
    }
    
    @objc func bounce() {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: nil)
        
     
    }

}
