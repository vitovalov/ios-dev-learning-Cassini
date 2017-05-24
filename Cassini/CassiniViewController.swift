//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Vito on 24/05/2017.
//  Copyright © 2017 Vitovalov. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let url = DemoURL.NASA[segue.identifier ?? ""]{
//            if let imageVC = (segue.destination as? ImageViewController) {
            if let imageVC = (segue.destination.contents as? ImageViewController) {
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
                
            }
        }
    }

}

/*
 It makes sense to make an extension here because this code has only to do with the VC and nothing with cassiniVC
 */
// it's showing the contents if I'm the navController, 
// otherwise its showing self
extension UIViewController {
    var contents: UIViewController {  // content: what this vc holds
        // if it's a navVC, it's the visible VC, if not,
        // then it's just itself
        
        if let navcon = self as? UINavigationController {// in other words: if I'm the navController
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}






















