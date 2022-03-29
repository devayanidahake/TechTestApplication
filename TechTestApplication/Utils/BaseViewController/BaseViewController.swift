//
//  BaseViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 29/03/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    //Put all stuffs which are common to all viewControllers
    func setNavigationAppearance(title:String) {
        self.navigationItem.title = title
    }
    
}
