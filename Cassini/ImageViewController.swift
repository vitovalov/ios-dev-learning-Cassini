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

    
    // MARK: Model
    
    var imageURL: URL? {
        didSet {
            image = nil
            // if I'm not on screen already.
            // so if I'm already on screen, fetch the image here
            if view.window != nil {
                fetchImage() // since it might be internet image
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    private func fetchImage() {
        if let url = imageURL {
            // now fetch happens blocking this thead
//            let urlContents = try? Data(contentsOf: url)
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in // this will make this self an optional version of itself only INSIDE this CLOSURE
                
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, url == self?.imageURL { // second part of if is to check that multiple clicks to fetchImage and first returns when nobody is waiting for him
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                    
                }
                // now this is not cancellable
            }
            
        }
    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        view.addSubview(imageView)
//        // this will cause immediate load from internet to the view and if this VC is reused in tabBar, would be done asap views loaded, but user haven't even seen them yet. All tabs would load the image from internet. BAD
//        // We want to load this image only when THIS VC appears
//        imageURL = DemoURL.stanford
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // so if I don't have an image yet, go fetch it.
        // delaying the fetch and ensuring that
        if image == nil {
            fetchImage()
        }
        
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0 // twice as big; 1.0 can't be bigger
            scrollView.contentSize = imageView.frame.size // enclosing entire imageView
            scrollView.addSubview(imageView)
        }
    }
    
    fileprivate var imageView = UIImageView() // it's private to everyone in this file (allows extensions to see this var)
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
            imageView.sizeToFit()//sizes its frame to whatever it has inside to match it
            // ? optional chaining to avoid crashing when imageURL gots setup from external thing via prepare segue
            scrollView?.contentSize = imageView.frame.size
            
//            spinner.stopAnimating() this could crash because all this set{} can be started during prepare phase of VC and the views are not set in that moment
            spinner?.stopAnimating()
        }
    }
}

// could also do this by adding ", UIScrollViewDelegate" at the top of VC
extension ImageViewController : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


























