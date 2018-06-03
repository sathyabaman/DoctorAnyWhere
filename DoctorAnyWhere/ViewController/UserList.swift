//
//  UserList.swift
//  DoctorAnyWhere
//
//  Created by viewQwest on 03/06/2018.
//  Copyright © 2018 sathyabaman. All rights reserved.
//

import UIKit
import Nuke

class UserList: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var UserCollectionView: UICollectionView!
    @IBOutlet var userModel: UserListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCollectionView.delegate = self
        UserCollectionView.dataSource = self
        self.title = "User List"
        userModel.fetchUsers {
            self.UserCollectionView.reloadData()
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userModel.numberOfItemsInSection(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width * 0.5) - 5 , height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        configureCell(cell: cell, forRowAtIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: CollectionViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.UserName?.text = userModel.titleforItemAtIndexPath(indexPath: indexPath)
        Manager.shared.loadImage(with: URL(string: userModel.getUserImageURl(indexPath: indexPath))!, into: cell.UserImage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UserDetail") as! SingleUser
        VC1.CurrentUser = userModel.getSingleUserDetails(indexPath: indexPath as NSIndexPath)
        let navController = UINavigationController(rootViewController: VC1)
        self.present(navController, animated:true, completion: nil)
    }
    
}
