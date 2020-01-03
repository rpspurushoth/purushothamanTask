//
//  DataModel.swift
//  Purushoth_Coding
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var title: String?
    var descriptions: String?
    var imageHref: String?
    
    init (dataJSON: NSDictionary){
        self.title = dataJSON["title"] as? String
        self.descriptions = dataJSON["description"] as? String
        self.imageHref = dataJSON["imageHref"] as? String
    }
}
