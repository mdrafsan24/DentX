//
//  GumVC.swift
//  DentX
//
//  Created by Rafsan Chowdhury on 11/5/17.
//  Copyright © 2017 appimas24. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class GumVC: UIViewController {
    
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var probGumDisease: UILabel!
    @IBOutlet weak var GumPic: UIImageView!
    let storageRef = Storage.storage()
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        GumPic.layer.cornerRadius = 5.0;
        GumPic.layer.borderColor = UIColor.black.cgColor
        GumPic.layer.borderWidth = 2.0;
        GumPic.layer.masksToBounds = true
        storageRef.reference().child("/gumImg.jpg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let pic = UIImage(data: data!)
            self.GumPic.image = pic
        }
        
        self.ref.observe(DataEventType.value) { (snapshot) in
            let postDict = snapshot.value as? [String : Any] ?? [:]
            var probgas = postDict["probGum"] as! NSNumber
            print ("This is it" , Int(Double(probgas)*100))
            self.probGumDisease.text = "\(Int(Double(probgas)*100))%"
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

