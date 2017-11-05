//
//  TongueVC.swift
//  DentX
//
//  Created by Rafsan Chowdhury on 11/5/17.
//  Copyright © 2017 appimas24. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class TongueVC: UIViewController {
    
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var probGastritis: UILabel!
    @IBOutlet weak var tonguePic: UIImageView!
    let storageRef = Storage.storage()
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        tonguePic.layer.cornerRadius = 5.0;
        tonguePic.layer.borderColor = UIColor.black.cgColor
        tonguePic.layer.borderWidth = 2.0;
        tonguePic.layer.masksToBounds = true
        storageRef.reference().child("/testImg.jpg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let pic = UIImage(data: data!)
            self.tonguePic.image = pic
        }
        
        self.ref.observe(DataEventType.value) { (snapshot) in
            let postDict = snapshot.value as? [String : Any] ?? [:]
            var probgas = postDict["probGas"] as! NSNumber
            print ("This is it" , Int(Double(probgas)*100))
            self.probGastritis.text = "\(Int(Double(probgas)*100))%"
        }
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
