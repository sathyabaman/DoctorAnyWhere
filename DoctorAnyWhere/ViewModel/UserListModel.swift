//
//  UserListModel.swift
//  DoctorAnyWhere
//
//  Created by viewQwest on 03/06/2018.
//  Copyright © 2018 sathyabaman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UserListModel: NSObject {
    var UserList = [UserModel]()
    var newOffset = 10
    
    func fetchUsers(completion: @escaping () -> ()){
        let baseUrl : String = "http://sd2-hiring.herokuapp.com/api/users?offset=10&limit=20"
        Alamofire.request(baseUrl, method: .get, encoding: JSONEncoding.default) .responseJSON { response in
            do {
                if response.data != nil {
                    let response = try JSON(data: response.data!)
                    for user in response["data"]["users"].arrayValue {
                        let SingleUser = UserModel()
                        SingleUser.name = user["name"].stringValue
                        SingleUser.image = user["image"].stringValue
                        for item in user["items"].arrayValue{
                            SingleUser.items.append(item.stringValue)
                        }
                        self.UserList.append(SingleUser)
                    }
                    completion()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMoreUsers(completion: @escaping () -> ()){
        newOffset += 1
        let baseUrl : String = "http://sd2-hiring.herokuapp.com/api/users?offset=\(newOffset)&limit=20"
        Alamofire.request(baseUrl, method: .get, encoding: JSONEncoding.default) .responseJSON { response in
            do {
                if response.data != nil {
                    let response = try JSON(data: response.data!)
                    for user in response["data"]["users"].arrayValue {
                        let SingleUser = UserModel()
                        SingleUser.name = user["name"].stringValue
                        SingleUser.image = user["image"].stringValue
                        for item in user["items"].arrayValue{
                            SingleUser.items.append(item.stringValue)
                        }
                        self.UserList.append(SingleUser)
                    }
                    completion()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
  
    func getTotalUserCount() -> Int{
        return UserList.count
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return UserList.count
    }
    
    func titleforItemAtIndexPath (indexPath: NSIndexPath) -> String {
        return (UserList[indexPath.row].name).replacingOccurrences(of: "-", with: " ")
    }
    
    func getUserImageURl(indexPath: NSIndexPath) -> String {
        return UserList[indexPath.row].image
    }
    
    func loadUserImage(indexPath: NSIndexPath) -> UIImage? {
        let url = URL(string: UserList[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            return UIImage(data: imageData)!
        } else {
            return nil
        }
    }
    
    func getSingleUserDetails(indexPath: NSIndexPath) -> UserModel {
        return UserList[indexPath.row]
    }
    
}
