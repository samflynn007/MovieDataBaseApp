//
//  UIViewController+ Ext.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//
import UIKit

extension UIViewController {
    
    enum StoryBoard: String {
         case main = "Main"
     }
    
    static func instance(_ storyboard: StoryBoard = .main) -> UIViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle(for: self))
        return storyBoard.instantiateViewController(withIdentifier: self.className)
    }
    
    static var className: String {
        get {
            return String(describing: self)
        }
    }
}

