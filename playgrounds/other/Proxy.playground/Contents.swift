// System design proxy part proof of concept

import Foundation


class Machine {
    var service: (() -> Void)? {
        didSet {
            execute()
        }
    }
    
    func execute() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(Int.random(in: 0...5))) { [self] in
            service?()
            service = nil
        }
    }
    
    var notifyWhenTaskFinish: (() -> Void)?
    
    var isAvailable: Bool {
        service == nil
    }
    
    var isReady: Bool {
        service != nil
    }
    
}

/*
 Proxy
 
 Benefits
 - Anonymity
 - Caching
 - Blocking unwanted sites
 - GeoFencing
 
 


 Reverse Proxy
 
 Benefits
 - Load Balancing
 - Caching
 - Isolating Internal traffic
 - Logging
 - Canary Deployment
 
 
 an Request delivering flow
 
 Generator an request                                         Request Consumer
      |                                                               |
    Clients -> Forwarding Proxy -> Internet -> Reverse Proxy --> a Cluster of servers
 
 */


class ReverseProxy {
    
    var machines: [Machine] = []
    
    private var taskIndex = 0
    typealias Request = () -> Void
    
    var messageQueue: [Request] = []
    
    func receive(_ request: @escaping Request) {
    
        if let availableMachine = machines.first(where:  { $0.isAvailable } ) {
            availableMachine.service = request
            availableMachine.notifyWhenTaskFinish = { [unowned self] in
                if taskIndex < messageQueue.count {
                    defer { taskIndex += 1  }
                    receive(messageQueue[taskIndex])
                }
            }
        } else {
            messageQueue.append(request)
        }
    }
}




