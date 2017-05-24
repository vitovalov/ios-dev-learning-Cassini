//
//  ImageViewController.swift
//  Cassini
//
//  Created by Vito on 24/05/2017.
//  Copyright © 2017 Vitovalov. All rights reserved.
//

import UIKit

/// VC that shows an image
class ImageViewController: UIViewController {

    var imageURL: URL?
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            imageView.image
        }
        
        set {
            imageView.image = newValue
            imageView.sizeToFit()//sizes its frame to whatever it has inside to match it
        }
    }
}





























