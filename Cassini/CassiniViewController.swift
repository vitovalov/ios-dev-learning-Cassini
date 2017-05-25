//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Vito on 24/05/2017.
//  Copyright © 2017 Vitovalov. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    
    // we want this to happen as early as possible
    override func awakeFromNib() {
        super.awakeFromNib()
        // self.splitViewController? means we want the delegate of splitVC if we are in one
        // my splitVC if I'm in one now
        self.splitViewController?.delegate = self //which requires us to implement UISplitViewControllerDelegate
        
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController, // sender
        collapseSecondary secondaryViewController: UIViewController, // pls collapse this secondary VC: that's a detail
        onto primaryViewController: UIViewController // this is the master
        // this is what was happening: a blank detail was putting on top of the master
    ) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageURL == nil {
                return true // we lie here: Yes I collapsed it, but actually not because it was blank
            }
        }
        return false // I haven't done anything. you do it
    }
    
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






















