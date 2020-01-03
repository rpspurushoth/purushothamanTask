//
//  APIService.swift
//  Purushoth_Coding
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import UIKit
import Alamofire

class APIService: NSObject {
    
    let serverUrl: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    func apiCallFromServer(urlString : String,
                           completion : @escaping (_ response : String?,
                                                    _ message: String?,
                                                    _ success : Bool)-> Void){
        Alamofire.request(serverUrl).responseString { (response) in          
                if response.result.isSuccess{
                    completion(response.result.value as String?,
                               "",
                               true)
                }else{
                    completion(response.error as? String,
                               "",
                               false)
                }
            }
    }

}


