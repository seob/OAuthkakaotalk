//
//  MainViewController.swift
//  OAuthexample
//
//  Created by seob on 2018. 7. 26..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction private func logoutDidTap(_ sender: Any){
        print("logout")
        KOSession.shared().logoutAndClose { [weak self] (success, error) in
            if (success){
                self?.dismiss(animated: true, completion: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KOSessionTask.userMeTask { (error, userme) in
            if let error = error as NSError? {
                switch error.code {
                case Int(KOErrorCancelled.rawValue) :
                    print("canceled")
                default : print(error.localizedDescription)
                }
            }
            
            guard let nick = userme?.nickname  else { return }
            
            
            self.nicknameLabel.text = nick
            
            //            let profileData =  try? Data(contentsOf: profile)
            //            let thumData =  try? Data(contentsOf: thum)
            //            self.profileImageView.image = UIImage(data: profileData)
            //            self.thumnailImageView.image = UIImage(data: thumData)
            
            self.profileImageView.image = UIImage(named: "noimage")
            self.self.thumnailImageView.image = UIImage(named: "noimage")
        }
        
    }
    
    
    
}
