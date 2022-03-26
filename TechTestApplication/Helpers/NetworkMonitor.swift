//
//  NetworkMonitor.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation
import Network

class NetworkMonitor {
    //MARK: Properties
    static let shared = NetworkMonitor()
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    
    //MARK: Methods
    /**
    This function checks if internet connection is available.
     Use status property to check the updated value.
     */
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                // post connected notification
            } else {
                // post disconnected notification
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
