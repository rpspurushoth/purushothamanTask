//
//  AlertInformation.swift
//  Purushoth_Coding
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import UIKit

class AlertInformation: NSObject {

    func displayAlertMessage(message: String , title: String, controller: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction.init(title: "OK", style: .default, handler: {(_: UIAlertAction!) in
        })
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .default, handler:{(_: UIAlertAction!) in
        })
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        controller.present(alert, animated: true, completion: nil)
    }

}
