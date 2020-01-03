//
//  NetworkConnectivity.swift
//  Purushoth_Coding
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

//import UIKit
import Foundation
import Alamofire

class NetworkConnectivity: NSObject {
    class var networkConnectionAvailable:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
