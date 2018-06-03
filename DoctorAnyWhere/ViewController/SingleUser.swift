//
//  SingleUser.swift
//  DoctorAnyWhere
//
//  Created by viewQwest on 03/06/2018.
//  Copyright © 2018 sathyabaman. All rights reserved.
//

import UIKit
import Nuke

class SingleUser: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var Collectionview: UICollectionView!
    @IBOutlet var singleUserModel : SingleUserModel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var DisplayName: UILabel!
    
    var  CurrentUser  = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayName.text = CurrentUser.name.replacingOccurrences(of: "-", with: " ")
        userImage.image = self.singleUserModel.loadImage(imageUrl: self.CurrentUser.image)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0) {
            return   singleUserModel.isevenItems(totalCount: CurrentUser.items.count) ? CGSize(width: (self.view.frame.width * 0.5) - 30, height: self.view.frame.height / 4) : CGSize(width: self.view.frame.width - 45 , height: self.view.frame.height / 4)
        } else {
            return CGSize(width:  (self.view.frame.width * 0.5) - 30, height: self.view.frame.height / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CurrentUser.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
        configureCell(cell: cell, forRowAtIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: UserDetailCell, forRowAtIndexPath indexPath: NSIndexPath) {
        Manager.shared.loadImage(with: URL(string: CurrentUser.items[indexPath.row])!, into: cell.ItemImage) 
    }


}
