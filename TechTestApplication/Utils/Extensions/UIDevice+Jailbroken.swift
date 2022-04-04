//
//  UIDevice+Jailbroken.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 03/04/22.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    func checkisDeviceJailBrocken() -> Bool {
        if UIDevice.current.isSimulator {
            return false // This should be true for real testing.
        }
        return false
    }
}
