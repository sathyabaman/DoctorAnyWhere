//
//  SingleUserModel.swift
//  DoctorAnyWhere
//
//  Created by viewQwest on 03/06/2018.
//  Copyright © 2018 sathyabaman. All rights reserved.
//

import UIKit

class SingleUserModel: NSObject {

    
    func loadImage(imageUrl: String) -> UIImage? {
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            return UIImage(data: imageData)! 
        } else {
            return nil
        }
    }
    
    
    func isevenItems(totalCount: Int) -> Bool{
        return totalCount % 2 == 0
    }
    
}
